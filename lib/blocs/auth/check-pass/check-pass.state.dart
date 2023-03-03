// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:equatable/equatable.dart';

abstract class CheckPassState extends Equatable {
  const CheckPassState();

  @override
  List<Object> get props => [];
}

class CheckPassInitial extends CheckPassState {}

class CheckPassLoading extends CheckPassState {}

class CheckPassSuccess extends CheckPassState {}

class CheckPassFailure extends CheckPassState {
  final String error;

  const CheckPassFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'CheckPassFailure { error: $error }';
}