// ignore: import_of_legacy_library_into_null_safe
import 'package:equatable/equatable.dart';

abstract class IncreaseWalletEvent extends Equatable {
  const IncreaseWalletEvent();

  @override
  List<Object> get props => [];
}

class IncreaseWalletButtonPressed extends IncreaseWalletEvent {
  final String amount;

  const IncreaseWalletButtonPressed({
    required this.amount,
  });

  @override
  List<Object> get props => [ amount];

  @override
  String toString() =>
      'IncreaseWalletButtonPressed { amount: $amount }';
}