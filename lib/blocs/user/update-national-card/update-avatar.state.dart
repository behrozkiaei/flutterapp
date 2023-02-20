// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:equatable/equatable.dart';

abstract class UpdateNationalCardState extends Equatable {
  const UpdateNationalCardState();

  @override
  List<Object> get props => [];
}

class UpdateNationalCardInitial extends UpdateNationalCardState {}

class UpdateNationalCardLoading extends UpdateNationalCardState {}

// ignore: must_be_immutable
class UpdateNationalCardSuccess extends UpdateNationalCardState {
   
}

class UpdateNationalCardFailure extends UpdateNationalCardState {
  final String error;

  const UpdateNationalCardFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'UpdateNationalCardFailure { error: $error }';
}