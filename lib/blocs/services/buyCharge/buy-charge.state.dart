// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:equatable/equatable.dart';
import 'package:paytel/models/TokenResponseModel.dart';
import 'package:paytel/models/transaction/bank-url-model.dart';

abstract class BuyChargeState extends Equatable {
  const BuyChargeState();

  @override
  List<Object> get props => [];
}

class BuyChargeInitial extends BuyChargeState {}

class BuyChargeLoading extends BuyChargeState {}

// ignore: must_be_immutable
class BuyChargeSuccess extends BuyChargeState {
    String? RedirectURL="" ; 
    BuyChargeSuccess(this.RedirectURL);
}

class BuyChargeFailure extends BuyChargeState {
  final String error;

  const BuyChargeFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'BuyChargeFailure { error: $error }';
}