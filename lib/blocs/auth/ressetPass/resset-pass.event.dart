// ignore: import_of_legacy_library_into_null_safe
import 'package:equatable/equatable.dart';

abstract class RessetPassEvent extends Equatable {
  const RessetPassEvent();

  @override
  List<Object> get props => [];
}

class RessetPassButtonPressed extends RessetPassEvent {
  final String mobile;

  const RessetPassButtonPressed({
    required this.mobile,
  });

  @override
  List<Object> get props => [mobile];

  @override
  String toString() =>
      'RessetPassButtonPressed { email: $mobile }';
}