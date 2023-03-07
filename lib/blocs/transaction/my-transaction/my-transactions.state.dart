// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:equatable/equatable.dart';
import 'package:paytel/models/transaction/bank-url-model.dart';
import 'package:paytel/models/transaction/my-transactions.dart';
import 'package:paytel/models/transaction/users-by-code-model.dart';


abstract class MyTransactionsState extends Equatable {
  const MyTransactionsState();

  @override
  List<Object> get props => [];
}

class MyTransactionsInitial extends MyTransactionsState {}

class MyTransactionsLoading extends MyTransactionsState {}

// ignore: must_be_immutable
class MyTransactionsSuccess extends MyTransactionsState {
  final  List<MyTransactions> myTransactions; 
  int index=0; 
  MyTransactionsSuccess(this.myTransactions, this.index);
   MyTransactionsSuccess copyWith({
        List<MyTransactions>? myTransactions,
        int? index,
    }) => 
        MyTransactionsSuccess(
            myTransactions ?? this.myTransactions,
            index ?? this.index,
        );


}

class MyTransactionsFailure extends MyTransactionsState {
  final String error;

  const MyTransactionsFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'MyTransactionsFailure { error: $error }';
}