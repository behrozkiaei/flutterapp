// ignore: import_of_legacy_library_into_null_safe
import 'package:equatable/equatable.dart';

abstract class BuyInternetEvent extends Equatable {
  const BuyInternetEvent();

  @override
  List<Object> get props => [];
}

class BuyInternetButtonPressed extends BuyInternetEvent {
  const BuyInternetButtonPressed({
        required this.productId,
        required this.InternetPayloadOperator,
        required this.mobile,
        required this.simType,
        required this.fromWallet,
  });

  final bool fromWallet;
  final String InternetPayloadOperator;
  final String mobile;
  final String productId;
  final String simType;

  @override
  List<Object> get props => [ fromWallet];

  @override
  String toString() =>
      'BuyInternetButtonPressed { amount: $mobile }';
}