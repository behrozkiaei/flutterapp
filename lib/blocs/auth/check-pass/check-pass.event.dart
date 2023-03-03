// ignore: import_of_legacy_library_into_null_safe
import 'package:equatable/equatable.dart';

abstract class CheckPassEvent extends Equatable {
  const CheckPassEvent();

  @override
  List<Object> get props => [];
}

class CheckPassButtonPressed extends CheckPassEvent {
  final String password;

  const CheckPassButtonPressed({
    required this.password,
  });

  @override
  List<Object> get props => [password];

  @override
  String toString() =>
      'CheckPassButtonPressed { email: $password }';
}