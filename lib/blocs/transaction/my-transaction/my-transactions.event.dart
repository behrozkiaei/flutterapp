// ignore: import_of_legacy_library_into_null_safe
import 'package:equatable/equatable.dart';

abstract class MyTransactionsEvent extends Equatable {
  const MyTransactionsEvent();

  @override
  List<Object> get props => [];
}

class MyTransactionsButtonPressed extends MyTransactionsEvent {
  final int page;

  const MyTransactionsButtonPressed({
    required this.page
  });

  @override
  List<Object> get props => [page];

  @override
  String toString() =>
      'MyTransactionsButtonPressed { page: $page}';
}

class ViewTransactionDetail extends MyTransactionsEvent {
  final int index;

  const ViewTransactionDetail({
    required this.index
  });

  @override
  List<Object> get props => [index];

  @override
  String toString() =>
      'MyTransactionsButtonPressed { page: $index}';
}