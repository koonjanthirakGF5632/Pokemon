part of 'login_email_pass_bloc.dart';

@immutable
abstract class LoginEmailPassEvent {}

class IntitialLoginEvent extends LoginEmailPassEvent{}
class LoginEvent extends LoginEmailPassEvent{
  String? email;
  String? password;

  LoginEvent({this.email,this.password});
}