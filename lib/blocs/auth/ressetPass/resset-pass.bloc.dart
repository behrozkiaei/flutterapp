import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:paytel/blocs/auth/ressetPass/resset-pass.event.dart';
import 'package:paytel/blocs/auth/ressetPass/resset-pass.state.dart';
import 'package:paytel/repositories/auth.repository.dart';


class RessetPassBloc extends Bloc<RessetPassEvent, RessetPassState> {
  UserRepository userRepository;

  RessetPassBloc({required this.userRepository}) : super(RessetPassInitial()){
    on<RessetPassButtonPressed>((event, emit) async {
      emit(RessetPassLoading());
      try {

       final  response = await userRepository.sendOtp(
         event.mobile
        );
        if(response.data['status']){
          emit(RessetPassSuccess());
        }else{
          emit(RessetPassFailure(error: response.data["message"] ?? "خطا در ورود رخ داده است"));   
       }
      } catch (e) {
        emit(RessetPassFailure( error: e.toString()));
      }
    });
  }

  
}