import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:nti_final_project/core/service/firebase_chat_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  FirebaseChatService chatService = FirebaseChatService();

  Future<void> signUp({required String name, required String email, required String password}) async {
    emit(AuthLoading());
    try {
      await chatService.signUp(name: name, email: email, password: password);
      emit(AuthSuccsess());
    }  on FirebaseAuthException catch (e) {
      log(chatService.handleAuthException(e));
      emit(AuthError(errMessage: chatService.handleAuthException(e)));
    }
      catch (e) {
      emit(AuthError(errMessage: 'Sign up failed: $e'));
    }
  }

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      await chatService.signIn(email: email, password: password);
      emit(AuthSuccsess());
    } on FirebaseAuthException catch (e) {
      log(chatService.handleAuthException(e));
      emit(AuthError(errMessage: chatService.handleAuthException(e)));
    }
      catch (e) {
      emit(AuthError(errMessage: 'Login failed: $e'));
    }
  }
}
