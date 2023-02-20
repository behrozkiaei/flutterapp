import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:paytel/blocs/auth/login/login.event.dart';
import 'package:paytel/blocs/auth/login/login.state.dart';
import 'package:paytel/models/TokenResponseModel.dart';
import 'package:paytel/repositories/auth.repository.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository userRepository;
  LoginBloc({required this.userRepository}) : super(LoginInitial()){
      on<LoginButtonPressed>((event, emit) async {
        emit(LoginLoading());
        try {
          final  response = await userRepository.verifyOtp(
            event.mobile,
            event.password
            );
            if(response.data['result'] != false ){
              final TokenResponseModel tokenObj = TokenResponseModel.fromJson(response.data['result']);
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setString("token" , tokenObj.token.accessToken);
                  emit(LoginSuccess());
            }else{
              emit(LoginFailure(error: response.data["message"] ?? "خطا در ورود رخ داده است"));   
          }
        } catch (e) {
            print(e);
          emit(LoginFailure( error: e.toString()));
        }
      });
    }
  }