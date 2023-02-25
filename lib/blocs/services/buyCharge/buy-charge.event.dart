// ignore: import_of_legacy_library_into_null_safe
import 'package:equatable/equatable.dart';

abstract class BuyChargeEvent extends Equatable {
  const BuyChargeEvent();

  @override
  List<Object> get props => [];
}

class BuyChargeButtonPressed extends BuyChargeEvent {
    final bool fromWallet;
    final String chargePayloadOperator;
    final String amount;
    final String mobile;
    final String chargeType;



  const BuyChargeButtonPressed({
        required this.chargeType,
        required this.chargePayloadOperator,
        required this.mobile,
        required this.amount,
        required this.fromWallet,
  });

  @override
  List<Object> get props => [ amount];

  @override
  String toString() =>
      'BuyChargeButtonPressed { amount: $mobile }';
}