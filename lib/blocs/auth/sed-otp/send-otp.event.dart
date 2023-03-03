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

class SendOtpRessetPassButtonPressed extends SendOtpEvent {

  const SendOtpRessetPassButtonPressed();

  @override
  List<Object> get props => [];

  @override
  String toString() =>
      'SendOtpButtonPressed { email:  }';
}