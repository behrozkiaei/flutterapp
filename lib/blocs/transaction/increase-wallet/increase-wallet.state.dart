// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:equatable/equatable.dart';
import 'package:paytel/models/TokenResponseModel.dart';
import 'package:paytel/models/transaction/bank-url-model.dart';

abstract class IncreaseWalletState extends Equatable {
  const IncreaseWalletState();

  @override
  List<Object> get props => [];
}

class IncreaseWalletInitial extends IncreaseWalletState {}

class IncreaseWalletLoading extends IncreaseWalletState {}

// ignore: must_be_immutable
class IncreaseWalletSuccess extends IncreaseWalletState {
     final BankUrl bankUrl ; 
     const IncreaseWalletSuccess(this.bankUrl);
}

class IncreaseWalletFailure extends IncreaseWalletState {
  final String error;

  const IncreaseWalletFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'IncreaseWalletFailure { error: $error }';
}