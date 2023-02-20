// ignore: import_of_legacy_library_into_null_safe
import 'package:equatable/equatable.dart';

abstract class UserByCodeEvent extends Equatable {
  const UserByCodeEvent();

  @override
  List<Object> get props => [];
}

class UserByCodeButtonPressed extends UserByCodeEvent {
  final String code;

  const UserByCodeButtonPressed({
    required this.code
  });

  @override
  List<Object> get props => [code];

  @override
  String toString() =>
      'UserByCodeButtonPressed { code: $code}';
}