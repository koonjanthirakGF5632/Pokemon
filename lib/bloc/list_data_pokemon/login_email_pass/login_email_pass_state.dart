part of 'login_email_pass_bloc.dart';

@immutable
abstract class LoginEmailPassState {}

class InitialLoginEmailPassState extends LoginEmailPassState {}
class LoginStateLoading extends LoginEmailPassState {}
class LoginStateCheckstatus extends LoginEmailPassState {}