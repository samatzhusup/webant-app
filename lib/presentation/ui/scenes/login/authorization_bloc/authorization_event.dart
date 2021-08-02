part of 'authorization_bloc.dart';

@immutable
abstract class AuthorizationEvent {}
class SignInEvent extends AuthorizationEvent{
  final String name;
  final String password;

  SignInEvent(this.name, this.password);
}
class SignUpEvent extends AuthorizationEvent{
  final String name;
  final String password;
  final String birthday;
  final String email;

  SignUpEvent(
      {this.name, this.password, this.birthday, this.email});
}
class LoginFetch extends AuthorizationEvent{}