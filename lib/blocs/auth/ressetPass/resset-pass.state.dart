// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:equatable/equatable.dart';

abstract class RessetPassState extends Equatable {
  const RessetPassState();

  @override
  List<Object> get props => [];
}

class RessetPassInitial extends RessetPassState {}

class RessetPassLoading extends RessetPassState {}

class RessetPassSuccess extends RessetPassState {}

class RessetPassFailure extends RessetPassState {
  final String error;

  const RessetPassFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'RessetPassFailure { error: $error }';
}