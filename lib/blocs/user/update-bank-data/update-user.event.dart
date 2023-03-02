// ignore: import_of_legacy_library_into_null_safe
import 'package:equatable/equatable.dart';

abstract class UpdateBankrEvent extends Equatable {
  const UpdateBankrEvent();

  @override
  List<Object> get props => [];
}

class UpdateBankrButtonPressed extends UpdateBankrEvent {
  final String card;
  final String sheba;

  const UpdateBankrButtonPressed({
    required this.card,
    required  this.sheba, 
  });

  @override
  List<Object> get props => [card , sheba];

  @override
  String toString() =>
      'UpdateBankrButtonPressed { email: , password:  }';
}