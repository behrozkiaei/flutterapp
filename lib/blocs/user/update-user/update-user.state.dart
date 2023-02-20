// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:equatable/equatable.dart';
import 'package:paytel/models/TokenResponseModel.dart';

abstract class UpdateUserState extends Equatable {
  const UpdateUserState();

  @override
  List<Object> get props => [];
}

class UpdateUserInitial extends UpdateUserState {}

class UpdateUserLoading extends UpdateUserState {}

// ignore: must_be_immutable
class UpdateUserSuccess extends UpdateUserState {
   
}

class UpdateUserFailure extends UpdateUserState {
  final String error;

  const UpdateUserFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'UpdateUserFailure { error: $error }';
}