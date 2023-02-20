// ignore: import_of_legacy_library_into_null_safe
import 'package:equatable/equatable.dart';

abstract class SendOtpEvent extends Equatable {
  const SendOtpEvent();

  @override
  List<Object> get props => [];
}

class SendOtpButtonPressed extends SendOtpEvent {
  final String mobile;

  const SendOtpButtonPressed({
    required this.mobile,
  });

  @override
  List<Object> get props => [mobile];

  @override
  String toString() =>
      'SendOtpButtonPressed { email: $mobile }';
}