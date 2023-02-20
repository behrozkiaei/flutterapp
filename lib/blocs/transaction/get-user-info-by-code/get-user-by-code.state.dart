// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:equatable/equatable.dart';
import 'package:paytel/models/transaction/bank-url-model.dart';
import 'package:paytel/models/transaction/users-by-code-model.dart';


abstract class UserByCodeState extends Equatable {
  const UserByCodeState();

  @override
  List<Object> get props => [];
}

class UserByCodeInitial extends UserByCodeState {}

class UserByCodeLoading extends UserByCodeState {}

// ignore: must_be_immutable
class UserByCodeSuccess extends UserByCodeState {
  final UserByCode user ; 
  const UserByCodeSuccess(this.user);
}

class UserByCodeFailure extends UserByCodeState {
  final String error;

  const UserByCodeFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'UserByCodeFailure { error: $error }';
}