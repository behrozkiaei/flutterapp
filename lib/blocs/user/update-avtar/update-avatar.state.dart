// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:equatable/equatable.dart';

abstract class UpdateAvatarState extends Equatable {
  const UpdateAvatarState();

  @override
  List<Object> get props => [];
}

class UpdateAvatarInitial extends UpdateAvatarState {}

class UpdateAvatarLoading extends UpdateAvatarState {}

// ignore: must_be_immutable
class UpdateAvatarSuccess extends UpdateAvatarState {
   
}

class UpdateAvatarFailure extends UpdateAvatarState {
  final String error;

  const UpdateAvatarFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'UpdateAvatarFailure { error: $error }';
}