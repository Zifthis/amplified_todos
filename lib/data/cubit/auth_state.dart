part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class Authenticated extends AuthState {
  final String userId;

  Authenticated({required this.userId});
}

class UnknownAuthState extends AuthState {}

class Unauthenticated extends AuthState {}
