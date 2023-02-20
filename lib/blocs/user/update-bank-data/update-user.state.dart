// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:equatable/equatable.dart';
import 'package:paytel/models/TokenResponseModel.dart';

abstract class UpdateBankrState extends Equatable {
  const UpdateBankrState();

  @override
  List<Object> get props => [];
}

class UpdateBankrInitial extends UpdateBankrState {}

class UpdateBankrLoading extends UpdateBankrState {}

// ignore: must_be_immutable
class UpdateBankrSuccess extends UpdateBankrState {
   
}

class UpdateBankrFailure extends UpdateBankrState {
  final String error;

  const UpdateBankrFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'UpdateBankrFailure { error: $error }';
}