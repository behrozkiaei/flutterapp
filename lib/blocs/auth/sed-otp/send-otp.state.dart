// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:equatable/equatable.dart';

abstract class SendOtpState extends Equatable {
  const SendOtpState();

  @override
  List<Object> get props => [];
}

class SendOtpInitial extends SendOtpState {}

class SendOtpLoading extends SendOtpState {}

class SendOtpSuccess extends SendOtpState {}

class SendOtpFailure extends SendOtpState {
  final String error;

  const SendOtpFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'SendOtpFailure { error: $error }';
}