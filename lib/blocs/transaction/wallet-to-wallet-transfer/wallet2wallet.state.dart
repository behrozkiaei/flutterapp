// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:equatable/equatable.dart';
import 'package:paytel/models/TokenResponseModel.dart';

abstract class Wallet2WalletState extends Equatable {
  const Wallet2WalletState();

  @override
  List<Object> get props => [];
}

class Wallet2WalletInitial extends Wallet2WalletState {}

class Wallet2WalletLoading extends Wallet2WalletState {}

class Wallet2WalletSuccess extends Wallet2WalletState {
   final String? RedirectURL ; 
   const Wallet2WalletSuccess( {this.RedirectURL});
}

class Wallet2WalletFailure extends Wallet2WalletState {
  final String error;

  const Wallet2WalletFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'Wallet2WalletFailure { error: $error }';
}