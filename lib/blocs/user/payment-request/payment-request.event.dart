// ignore: import_of_legacy_library_into_null_safe
import 'package:equatable/equatable.dart';

abstract class PaymentRequestEvent extends Equatable {
  const PaymentRequestEvent();

  @override
  List<Object> get props => [];
}

class PaymentRequestButtonPressed extends PaymentRequestEvent {
  final String amount;

  const PaymentRequestButtonPressed({
    required this.amount,
  });

  @override
  List<Object> get props => [amount];

  @override
  String toString() =>
      'PaymentRequestButtonPressed ';
}
class GetAllPaymentRequestButtonPressed extends PaymentRequestEvent {

  const GetAllPaymentRequestButtonPressed();

  @override
  List<Object> get props => [];

  @override
  String toString() =>
      'PaymentRequestButtonPressed ';
}
class DeletePaymentRequestButtonPressed extends PaymentRequestEvent {
  final String id;

  const DeletePaymentRequestButtonPressed({
    required this.id,
  });

  @override
  List<Object> get props => [id];

  @override
  String toString() =>
      'PaymentRequestButtonPressed ';
}