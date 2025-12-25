class AuthState {}

class InitalAuthState extends AuthState {}

class LoadingAuthState extends AuthState {}

class SuccsessAuthState extends AuthState {}

class ErrorAuthState extends AuthState {
  final String errorMessage;
  ErrorAuthState({required this.errorMessage});
}
