// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:equatable/equatable.dart';
import 'package:paytel/models/me-model.dart';

abstract class MeState extends Equatable {
  const MeState();

  @override
  List<Object> get props => [];
}

class MeInitial extends MeState {}

class MeLoading extends MeState {}

class MeSuccess extends MeState {
  MeModel? me ; 
  MeSuccess(this.me);
}

class MeFailure extends MeState {
  final String error;

  const MeFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'MeFailure { error: $error }';
}