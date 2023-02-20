// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:equatable/equatable.dart';

abstract class UpdateIdentityImageState extends Equatable {
  const UpdateIdentityImageState();

  @override
  List<Object> get props => [];
}

class UpdateIdentityImageInitial extends UpdateIdentityImageState {}

class UpdateIdentityImageLoading extends UpdateIdentityImageState {}

// ignore: must_be_immutable
class UpdateIdentityImageSuccess extends UpdateIdentityImageState {
   
}

class UpdateIdentityImageFailure extends UpdateIdentityImageState {
  final String error;

  const UpdateIdentityImageFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'UpdateIdentityImageFailure { error: $error }';
}