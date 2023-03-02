// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:equatable/equatable.dart';
import 'package:paytel/models/payment-requests-model.dart';

abstract class PaymentRequestState extends Equatable {
  const PaymentRequestState();

  @override
  List<Object> get props => [];
}

class PaymentRequestInitial extends PaymentRequestState {}

class PaymentRequestLoading extends PaymentRequestState {}
class PaymentRequestSuccess extends PaymentRequestState {
}
class PaymentRequestListSuccess extends PaymentRequestState {

  final  List<PaymentRequestModel> paymentRequests ;
  const PaymentRequestListSuccess(this.paymentRequests);
}

class PaymentRequestFailure extends PaymentRequestState {
  final String error;

  const PaymentRequestFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'PaymentRequestFailure { error: $error }';
}