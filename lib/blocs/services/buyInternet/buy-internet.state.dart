// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:equatable/equatable.dart';
import 'package:paytel/models/TokenResponseModel.dart';
import 'package:paytel/models/transaction/bank-url-model.dart';

abstract class BuyInternetState extends Equatable {
  const BuyInternetState();

  @override
  List<Object> get props => [];
}

class BuyInternetInitial extends BuyInternetState {}

class BuyInternetLoading extends BuyInternetState {}

// ignore: must_be_immutable
class BuyInternetSuccess extends BuyInternetState {
    String? RedirectURL="" ; 
    BuyInternetSuccess(this.RedirectURL);
}

class BuyInternetFailure extends BuyInternetState {
  final String error;

  const BuyInternetFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'BuyInternetFailure { error: $error }';
}