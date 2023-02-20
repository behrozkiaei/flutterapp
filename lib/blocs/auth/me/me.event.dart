// ignore: import_of_legacy_library_into_null_safe
import 'package:equatable/equatable.dart';

abstract class MeEvent extends Equatable {
  const MeEvent();

  @override
  List<Object> get props => [];
}

class StartFetchMe extends MeEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() =>
      'MeButtonPressed ';
}