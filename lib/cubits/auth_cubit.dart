import 'package:bloc/bloc.dart';
import 'package:nti_final_project/cubits/auth_state.dart';
import 'package:nti_final_project/firebase/firebase_db.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.firebaseDb) : super(InitalAuthState());
  FirebaseDb firebaseDb;

  // register
  Future<void> register(String name, String email, String password) async {
    emit(LoadingAuthState());
    try {
      await firebaseDb.register(name, email, password);
      emit(SuccsessAuthState());
    } catch (e) {
      emit(ErrorAuthState(errorMessage: e.toString()));
    }
  }

  // login
  Future<void> login(String email, String password) async {
    emit(LoadingAuthState());
    try {
      await firebaseDb.login(email, password);
      emit(SuccsessAuthState());
    } catch (e) {
      emit(ErrorAuthState(errorMessage: e.toString()));
    }
  }
}
