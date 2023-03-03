import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:paytel/blocs/auth/ressetPass/resset-pass.event.dart';
import 'package:paytel/blocs/auth/ressetPass/resset-pass.state.dart';
import 'package:paytel/repositories/auth.repository.dart';
import 'package:shared_preferences/shared_preferences.dart';


class RessetPassBloc extends Bloc<RessetPassEvent, RessetPassState> {
  UserRepository userRepository;

  RessetPassBloc({required this.userRepository}) : super(RessetPassInitial()){
    on<RessetPassButtonPressed>((event, emit) async {
      emit(RessetPassLoading());
      try {
       final  response = await userRepository.setPass(
         event.password,
        );
        if(response.data['status']){
          final prefs = await SharedPreferences.getInstance();
          prefs.setString("password", event.password);
          prefs.setString("token",response.data['result']['token']);
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