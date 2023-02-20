import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:paytel/blocs/auth/sed-otp/send-otp.event.dart';
import 'package:paytel/blocs/auth/sed-otp/send-otp.state.dart';
import 'package:paytel/repositories/auth.repository.dart';


class SendOtpBloc extends Bloc<SendOtpEvent, SendOtpState> {
  UserRepository userRepository;

  SendOtpBloc({required this.userRepository}) : super(SendOtpInitial()){
    on<SendOtpButtonPressed>((event, emit) async {
      emit(SendOtpLoading());
      try {

       final  response = await userRepository.sendOtp(
         event.mobile
        );
        if(response.data['status']){
          emit(SendOtpSuccess());
        }else{
          emit(SendOtpFailure(error: response.data["message"] ?? "خطا در ورود رخ داده است"));   
       }
      } catch (e) {
        emit(SendOtpFailure( error: e.toString()));
      }
    });
  }

  
}