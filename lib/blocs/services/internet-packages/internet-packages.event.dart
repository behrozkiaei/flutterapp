// ignore: import_of_legacy_library_into_null_safe
import 'package:equatable/equatable.dart';

abstract class InternetPackagesEvent extends Equatable {
  const InternetPackagesEvent();

  @override
  List<Object> get props => [];
}

class InternetPackagesButtonPressed extends InternetPackagesEvent {
  const InternetPackagesButtonPressed();

  @override
  List<Object> get props => [];

  @override
  String toString() =>
      'InternetPackagesButtonPressed { page: }';
}