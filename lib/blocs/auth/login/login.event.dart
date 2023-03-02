// ignore: import_of_legacy_library_into_null_safe
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  final String mobile;
  final String password;

  const LoginButtonPressed({
    required this.mobile,
    required this.password,
  });

  @override
  List<Object> get props => [mobile, password];

  @override
  String toString() =>
      'LoginButtonPressed { email: $mobile, password: $password }';
}


class SettPasswordEvent extends LoginEvent {
  final String userId;
  final String password;
  final String uid;

  const SettPasswordEvent({
    required this.userId,
    required this.password,
    required this.uid,
  });

  @override
  List<Object> get props => [userId, password,uid];

  @override
  String toString() =>
      'LoginButtonPressed { email: $userId, password: $password }';
}

class LoginToAppEvent extends LoginEvent {
  final String password;

  const LoginToAppEvent({
    required this.password,
  });

  @override
  List<Object> get props => [password];

  @override
  String toString() =>
      'LoginButtonPressed {  password: $password }';
}