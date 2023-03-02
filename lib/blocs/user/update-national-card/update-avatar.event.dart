// ignore: import_of_legacy_library_into_null_safe
import 'package:equatable/equatable.dart';

abstract class UpdateNationalCardEvent extends Equatable {
  const UpdateNationalCardEvent();

  @override
  List<Object> get props => [];
}

class UpdateNationalCardButtonPressed extends UpdateNationalCardEvent {
  final String cartMelli;

  const UpdateNationalCardButtonPressed({
    required this.cartMelli
  });

  @override
  List<Object> get props => [cartMelli];

  @override
  String toString() =>
      'UpdateNationalCardButtonPressed ';
}