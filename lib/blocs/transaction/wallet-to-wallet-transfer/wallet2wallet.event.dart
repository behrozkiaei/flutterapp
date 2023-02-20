// ignore: import_of_legacy_library_into_null_safe
import 'package:equatable/equatable.dart';

abstract class Wallet2WalletEvent extends Equatable {
  const Wallet2WalletEvent();

  @override
  List<Object> get props => [];
}

class Wallet2WalletButtonPressed extends Wallet2WalletEvent {
  final String walletCode;
  final String amount;

  const Wallet2WalletButtonPressed({
    required this.walletCode,
    required this.amount,
  });

  @override
  List<Object> get props => [amount, walletCode];

  @override
  String toString() =>
      'Wallet2WalletButtonPressed { code: $walletCode, amount: $amount }';

  void add(Wallet2WalletButtonPressed wallet2walletButtonPressed) {}
}