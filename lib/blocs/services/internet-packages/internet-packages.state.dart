// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:equatable/equatable.dart';
import 'package:paytel/models/internet-packages-model.model.dart';
import 'package:paytel/models/transaction/bank-url-model.dart';
import 'package:paytel/models/transaction/my-transactions.dart';
import 'package:paytel/models/transaction/users-by-code-model.dart';


abstract class InternetPackagesState extends Equatable {
  const InternetPackagesState();

  @override
  List<Object> get props => [];
}

class InternetPackagesInitial extends InternetPackagesState {}

class InternetPackagesLoading extends InternetPackagesState {}

// ignore: must_be_immutable
class InternetPackagesSuccess extends InternetPackagesState {
  final  List<InternetPackagesModel> internetPackages; 
  const InternetPackagesSuccess(this.internetPackages);
}

class InternetPackagesFailure extends InternetPackagesState {
  final String error;

  const InternetPackagesFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'InternetPackagesFailure { error: $error }';
}