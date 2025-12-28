import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nti_final_project/features/auth/model/user_model.dart';
import 'package:nti_final_project/features/chats%20_%20conversation/model/chats_model.dart';
import 'package:nti_final_project/features/chats%20_%20conversation/model/group_model.dart';
import 'package:nti_final_project/features/chats%20_%20conversation/model/mesage_model.dart';
import 'package:nti_final_project/features/chats/model/user_chat_item.dart';

class FirebaseChatService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current user ID
  String? get currentUserId => _auth.currentUser?.uid;

  // Sign Up with Email and Password
  Future<User?> signUp({
    required String email,
    required String password,
    required String name,
    String? photoURL,
  }) async {
    try {
      // Create user in Firebase Auth
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;

      if (user != null) {
        // Update display name
        await user.updateDisplayName(name);
        if (photoURL != null) {
          await user.updatePhotoURL(photoURL);
        }

        // Create user document in Firestore
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'name': name,
          'email': email,
          'photoURL': photoURL,
          'status': 'online',
          'lastSeen': FieldValue.serverTimestamp(),
          'createdAt': FieldValue.serverTimestamp(),
          'fcmToken': null,
        });

        // Initialize empty userChats document
        await _firestore.collection('userChats').doc(user.uid).set({
          'chats': {},
        });

        return user;
      }
    } on FirebaseAuthException catch (e) {
      throw handleAuthException(e);
    } catch (e) {
      throw Exception('Sign up failed: $e');
    }
    return null;
  }

  // Sign In with Email and Password
  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update user status to online
      if (userCredential.user != null) {
        await updateUserStatus('online');
      }

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw handleAuthException(e);
    } catch (e) {
      throw Exception('Sign in failed: $e');
    }
  }

  // Sign Out
  Future<void> signOut() async {
    try {
      // Update status to offline before signing out
      await updateUserStatus('offline');
      await _auth.signOut();
    } catch (e) {
      throw Exception('Sign out failed: $e');
    }
  }

  // Update User Status (online, offline, away)
  Future<void> updateUserStatus(String status) async {
    if (currentUserId != null) {
      await _firestore.collection('users').doc(currentUserId).update({
        'status': status,
        'lastSeen': FieldValue.serverTimestamp(),
      });
    }
  }

  // Update FCM Token for notifications
  Future<void> updateFCMToken(String token) async {
    if (currentUserId != null) {
      await _firestore.collection('users').doc(currentUserId).update({
        'fcmToken': token,
      });
    }
  }

  // ============ USER MANAGEMENT ============

  // Get Current User Data
  Future<UserModel?> getCurrentUser() async {
    if (currentUserId == null) return null;

    try {
      DocumentSnapshot doc = await _firestore
          .collection('users')
          .doc(currentUserId)
          .get();

      if (doc.exists) {
        return UserModel.fromJson(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      throw Exception('Failed to get current user: $e');
    }
    return null;
  }

  // Get User by ID
  Future<UserModel?> getUserById(String userId) async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection('users')
          .doc(userId)
          .get();

      if (doc.exists) {
        return UserModel.fromJson(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      throw Exception('Failed to get user: $e');
    }
    return null;
  }

  // Search Users by Name or Email
  Future<List<UserModel>> searchUsers(String query) async {
    try {
      // Search by name
      QuerySnapshot nameSnapshot = await _firestore
          .collection('users')
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThanOrEqualTo: '$query\uf8ff')
          .limit(20)
          .get();

      // Search by email
      QuerySnapshot emailSnapshot = await _firestore
          .collection('users')
          .where('email', isGreaterThanOrEqualTo: query)
          .where('email', isLessThanOrEqualTo: '$query\uf8ff')
          .limit(20)
          .get();

      // Combine and remove duplicates
      Set<String> userIds = {};
      List<UserModel> users = [];

      for (var doc in nameSnapshot.docs) {
        if (!userIds.contains(doc.id) && doc.id != currentUserId) {
          userIds.add(doc.id);
          users.add(UserModel.fromJson(doc.data() as Map<String, dynamic>));
        }
      }

      for (var doc in emailSnapshot.docs) {
        if (!userIds.contains(doc.id) && doc.id != currentUserId) {
          userIds.add(doc.id);
          users.add(UserModel.fromJson(doc.data() as Map<String, dynamic>));
        }
      }

      return users;
    } catch (e) {
      throw Exception('Failed to search users: $e');
    }
  }

  // Get All Users (for displaying friends list)
  Future<List<UserModel>> getAllUsers() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .where('uid', isNotEqualTo: currentUserId)
          .get();

      return snapshot.docs
          .map((doc) => UserModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to get all users: $e');
    }
  }

  // Stream Current User Data
  Stream<UserModel?> streamCurrentUser() {
    if (currentUserId == null) return Stream.value(null);

    return _firestore.collection('users').doc(currentUserId).snapshots().map((
      doc,
    ) {
      if (doc.exists) {
        return UserModel.fromJson(doc.data() as Map<String, dynamic>);
      }
      return null;
    });
  }

  // ============ CHAT MANAGEMENT ============

  // Create or Get Direct Chat
  Future<String> createOrGetDirectChat(String otherUserId) async {
    if (currentUserId == null) throw Exception('User not authenticated');

    try {
      // Generate chat ID
      String chatId = ChatModel.generateChatId(currentUserId!, otherUserId);

      // Check if chat already exists
      DocumentSnapshot chatDoc = await _firestore
          .collection('chats')
          .doc(chatId)
          .get();

      if (!chatDoc.exists) {
        // Get user data
        UserModel? currentUser = await getUserById(currentUserId!);
        UserModel? otherUser = await getUserById(otherUserId);

        if (currentUser == null || otherUser == null) {
          throw Exception('User data not found');
        }

        // Create new chat document
        await _firestore.collection('chats').doc(chatId).set({
          'participants': [currentUserId, otherUserId],
          'participantsData': {
            currentUserId!: {
              'name': currentUser.name,
              'photoURL': currentUser.photoURL,
            },
            otherUserId: {
              'name': otherUser.name,
              'photoURL': otherUser.photoURL,
            },
          },
          'lastMessage': null,
          'updatedAt': FieldValue.serverTimestamp(),
          'createdAt': FieldValue.serverTimestamp(),
        });

        // Add chat to both users' userChats
        await _firestore.collection('userChats').doc(currentUserId).set({
          'chats': {
            chatId: {
              'type': 'direct',
              'lastMessage': '',
              'lastMessageTime': FieldValue.serverTimestamp(),
              'unreadCount': 0,
              'otherUserId': otherUserId,
              'otherUserName': otherUser.name,
              'otherUserPhoto': otherUser.photoURL,
            },
          },
        }, SetOptions(merge: true));

        await _firestore.collection('userChats').doc(otherUserId).set({
          'chats': {
            chatId: {
              'type': 'direct',
              'lastMessage': '',
              'lastMessageTime': FieldValue.serverTimestamp(),
              'unreadCount': 0,
              'otherUserId': currentUserId,
              'otherUserName': currentUser.name,
              'otherUserPhoto': currentUser.photoURL,
            },
          },
        }, SetOptions(merge: true));
      }

      return chatId;
    } catch (e) {
      throw Exception('Failed to create chat: $e');
    }
  }

  // Send Message in Direct Chat
  Future<void> sendMessage({
    required String chatId,
    required String text,
    String type = 'text',
    String? imageUrl,
    String? fileUrl,
    String? fileName,
  }) async {
    if (currentUserId == null) throw Exception('User not authenticated');

    try {
      UserModel? currentUser = await getUserById(currentUserId!);
      if (currentUser == null) throw Exception('User not found');

      // Create message document
      await _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .add({
            'text': text,
            'senderId': currentUserId,
            'senderName': currentUser.name,
            'timestamp': FieldValue.serverTimestamp(),
            'read': false,
            'type': type,
            'imageUrl': imageUrl,
            'fileUrl': fileUrl,
            'fileName': fileName,
          });

      // Update last message in chat document
      await _firestore.collection('chats').doc(chatId).update({
        'lastMessage': {
          'text': text,
          'senderId': currentUserId,
          'timestamp': FieldValue.serverTimestamp(),
          'read': false,
        },
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // Get chat participants
      DocumentSnapshot chatDoc = await _firestore
          .collection('chats')
          .doc(chatId)
          .get();

      if (chatDoc.exists) {
        ChatModel chat = ChatModel.fromJson(
          chatId,
          chatDoc.data() as Map<String, dynamic>,
        );

        // Update userChats for all participants
        for (String participantId in chat.participants) {
          bool isCurrentUser = participantId == currentUserId;

          await _firestore.collection('userChats').doc(participantId).set({
            'chats': {
              chatId: {
                'lastMessage': text,
                'lastMessageTime': FieldValue.serverTimestamp(),
                'unreadCount': isCurrentUser ? 0 : FieldValue.increment(1),
              },
            },
          }, SetOptions(merge: true));
        }
      }
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }

  // Mark Messages as Read
  Future<void> markMessagesAsRead(String chatId, String otherUserId) async {
    if (currentUserId == null) return;

    try {
      // Get unread messages
      QuerySnapshot unreadMessages = await _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .where('senderId', isEqualTo: otherUserId)
          .where('read', isEqualTo: false)
          .get();

      // Mark all as read
      WriteBatch batch = _firestore.batch();

      for (var doc in unreadMessages.docs) {
        batch.update(doc.reference, {'read': true});
      }

      await batch.commit();

      // Reset unread count in userChats
      await _firestore.collection('userChats').doc(currentUserId).set({
        'chats': {
          chatId: {'unreadCount': 0},
        },
      }, SetOptions(merge: true));
    } catch (e) {
      throw Exception('Failed to mark messages as read: $e');
    }
  }

  // Stream User's Chats
  Stream<UserChats?> streamUserChats() {
    if (currentUserId == null) return Stream.value(null);

    return _firestore
        .collection('userChats')
        .doc(currentUserId)
        .snapshots()
        .map((doc) {
          if (doc.exists) {
            return UserChats.fromSnapshot(doc);
          }
          return null;
        });
  }

  // Stream Messages in a Chat
  Stream<List<MessageModel>> streamMessages(String chatId) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => MessageModel.fromJson(doc.id, doc.data()))
              .toList(),
        );
  }

  // ============ GROUP MANAGEMENT ============

  // Create Group
  Future<String> createGroup({
    required String name,
    String? description,
    String? photoURL,
    required List<String> memberIds,
  }) async {
    if (currentUserId == null) throw Exception('User not authenticated');

    try {
      UserModel? currentUser = await getUserById(currentUserId!);
      if (currentUser == null) throw Exception('User not found');

      // Create group document
      DocumentReference groupRef = await _firestore.collection('groups').add({
        'name': name,
        'description': description,
        'photoURL': photoURL,
        'adminIds': [currentUserId],
        'memberIds': [currentUserId, ...memberIds],
        'membersData': {
          currentUserId!: {
            'name': currentUser.name,
            'photoURL': currentUser.photoURL,
            'role': 'admin',
          },
        },
        'lastMessage': null,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      String groupId = groupRef.id;

      // Add member data for all members
      for (String memberId in memberIds) {
        UserModel? member = await getUserById(memberId);
        if (member != null) {
          await groupRef.update({
            'membersData.$memberId': {
              'name': member.name,
              'photoURL': member.photoURL,
              'role': 'member',
            },
          });
        }
      }

      // Add group to all members' userChats
      List<String> allMembers = [currentUserId!, ...memberIds];
      for (String memberId in allMembers) {
        await _firestore.collection('userChats').doc(memberId).set({
          'chats': {
            groupId: {
              'type': 'group',
              'groupName': name,
              'groupPhoto': photoURL,
              'lastMessage': '',
              'lastMessageTime': FieldValue.serverTimestamp(),
              'unreadCount': 0,
            },
          },
        }, SetOptions(merge: true));
      }

      return groupId;
    } catch (e) {
      throw Exception('Failed to create group: $e');
    }
  }

  // Send Message in Group
  Future<void> sendGroupMessage({
    required String groupId,
    required String text,
    String type = 'text',
    String? imageUrl,
    String? fileUrl,
    String? fileName,
  }) async {
    if (currentUserId == null) throw Exception('User not authenticated');

    try {
      UserModel? currentUser = await getUserById(currentUserId!);
      if (currentUser == null) throw Exception('User not found');

      // Create message document
      await _firestore
          .collection('groups')
          .doc(groupId)
          .collection('messages')
          .add({
            'text': text,
            'senderId': currentUserId,
            'senderName': currentUser.name,
            'timestamp': FieldValue.serverTimestamp(),
            'type': type,
            'readBy': [currentUserId], // Sender has read it
            'imageUrl': imageUrl,
            'fileUrl': fileUrl,
            'fileName': fileName,
          });

      // Update last message in group document
      await _firestore.collection('groups').doc(groupId).update({
        'lastMessage': {
          'text': text,
          'senderId': currentUserId,
          'senderName': currentUser.name,
          'timestamp': FieldValue.serverTimestamp(),
        },
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // Get group members
      DocumentSnapshot groupDoc = await _firestore
          .collection('groups')
          .doc(groupId)
          .get();

      if (groupDoc.exists) {
        GroupModel group = GroupModel.fromSnapshot(groupDoc);

        // Update userChats for all members
        for (String memberId in group.memberIds) {
          bool isCurrentUser = memberId == currentUserId;

          await _firestore.collection('userChats').doc(memberId).set({
            'chats': {
              groupId: {
                'lastMessage': text,
                'lastMessageTime': FieldValue.serverTimestamp(),
                'unreadCount': isCurrentUser ? 0 : FieldValue.increment(1),
              },
            },
          }, SetOptions(merge: true));
        }
      }
    } catch (e) {
      throw Exception('Failed to send group message: $e');
    }
  }

  // Mark Group Message as Read
  Future<void> markGroupMessageAsRead(String groupId, String messageId) async {
    if (currentUserId == null) return;

    try {
      await _firestore
          .collection('groups')
          .doc(groupId)
          .collection('messages')
          .doc(messageId)
          .update({
            'readBy': FieldValue.arrayUnion([currentUserId]),
          });
    } catch (e) {
      throw Exception('Failed to mark message as read: $e');
    }
  }

  // Stream Group Messages
  Stream<List<GroupMessageModel>> streamGroupMessages(String groupId) {
    return _firestore
        .collection('groups')
        .doc(groupId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => GroupMessageModel.fromSnapshot(doc))
              .toList(),
        );
  }

  // Get Group Details
  Future<GroupModel?> getGroup(String groupId) async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection('groups')
          .doc(groupId)
          .get();

      if (doc.exists) {
        return GroupModel.fromSnapshot(doc);
      }
    } catch (e) {
      throw Exception('Failed to get group: $e');
    }
    return null;
  }

  // Stream Group Details
  Stream<GroupModel?> streamGroup(String groupId) {
    return _firestore.collection('groups').doc(groupId).snapshots().map((doc) {
      if (doc.exists) {
        return GroupModel.fromSnapshot(doc);
      }
      return null;
    });
  }

  // Add Member to Group
  Future<void> addMemberToGroup(String groupId, String userId) async {
    if (currentUserId == null) throw Exception('User not authenticated');

    try {
      UserModel? user = await getUserById(userId);
      if (user == null) throw Exception('User not found');

      GroupModel? group = await getGroup(groupId);
      if (group == null) throw Exception('Group not found');

      // Check if current user is admin
      if (!group.isAdmin(currentUserId!)) {
        throw Exception('Only admins can add members');
      }

      // Add member to group
      await _firestore.collection('groups').doc(groupId).update({
        'memberIds': FieldValue.arrayUnion([userId]),
        'membersData.$userId': {
          'name': user.name,
          'photoURL': user.photoURL,
          'role': 'member',
        },
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // Add group to user's userChats
      await _firestore.collection('userChats').doc(userId).set({
        'chats': {
          groupId: {
            'type': 'group',
            'groupName': group.name,
            'groupPhoto': group.photoURL,
            'lastMessage': group.lastMessage?.text ?? '',
            'lastMessageTime': FieldValue.serverTimestamp(),
            'unreadCount': 0,
          },
        },
      }, SetOptions(merge: true));
    } catch (e) {
      throw Exception('Failed to add member: $e');
    }
  }

  // Remove Member from Group
  Future<void> removeMemberFromGroup(String groupId, String userId) async {
    if (currentUserId == null) throw Exception('User not authenticated');

    try {
      GroupModel? group = await getGroup(groupId);
      if (group == null) throw Exception('Group not found');

      // Check if current user is admin
      if (!group.isAdmin(currentUserId!)) {
        throw Exception('Only admins can remove members');
      }

      // Remove member from group
      await _firestore.collection('groups').doc(groupId).update({
        'memberIds': FieldValue.arrayRemove([userId]),
        'membersData.$userId': FieldValue.delete(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // Remove group from user's userChats
      await _firestore.collection('userChats').doc(userId).update({
        'chats.$groupId': FieldValue.delete(),
      });
    } catch (e) {
      throw Exception('Failed to remove member: $e');
    }
  }

  // Leave Group
  Future<void> leaveGroup(String groupId) async {
    if (currentUserId == null) throw Exception('User not authenticated');

    try {
      GroupModel? group = await getGroup(groupId);
      if (group == null) throw Exception('Group not found');

      // If user is admin and there are other members, transfer admin rights
      if (group.isAdmin(currentUserId!) && group.memberIds.length > 1) {
        String newAdmin = group.memberIds.firstWhere(
          (id) => id != currentUserId,
          orElse: () => '',
        );

        if (newAdmin.isNotEmpty) {
          await _firestore.collection('groups').doc(groupId).update({
            'adminIds': FieldValue.arrayUnion([newAdmin]),
            'membersData.$newAdmin.role': 'admin',
          });
        }
      }

      // Remove current user from group
      await _firestore.collection('groups').doc(groupId).update({
        'memberIds': FieldValue.arrayRemove([currentUserId]),
        'adminIds': FieldValue.arrayRemove([currentUserId]),
        'membersData.$currentUserId': FieldValue.delete(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // Remove group from user's userChats
      await _firestore.collection('userChats').doc(currentUserId).update({
        'chats.$groupId': FieldValue.delete(),
      });

      // If no members left, delete the group
      DocumentSnapshot updatedGroup = await _firestore
          .collection('groups')
          .doc(groupId)
          .get();

      if (updatedGroup.exists) {
        List<dynamic> members =
            (updatedGroup.data() as Map<String, dynamic>)['memberIds'] ?? [];
        if (members.isEmpty) {
          await _firestore.collection('groups').doc(groupId).delete();
        }
      }
    } catch (e) {
      throw Exception('Failed to leave group: $e');
    }
  }

  // ============ HELPER METHODS ============

  String handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        return 'An account already exists for that email.';
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided.';
      case 'invalid-email':
        return 'Invalid email address.';
      case 'user-disabled':
        return 'This user has been disabled.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'operation-not-allowed':
        return 'This operation is not allowed.';
      default:
        return 'Authentication failed: ${e.message}';
    }
  }
}
