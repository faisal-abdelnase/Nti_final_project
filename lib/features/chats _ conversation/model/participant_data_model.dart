class ParticipantData {
  final String name;
  final String? photoURL;

  ParticipantData({
    required this.name,
    this.photoURL,
  });

  factory ParticipantData.fromJson(Map<String, dynamic> map) {
    return ParticipantData(
      name: map['name'] ?? '',
      photoURL: map['photoURL'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'photoURL': photoURL,
    };
  }
}