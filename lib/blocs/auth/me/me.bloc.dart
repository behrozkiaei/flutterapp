import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:paytel/blocs/auth/me/me.event.dart';
import 'package:paytel/blocs/auth/me/me.state.dart';
import 'package:paytel/models/me-model.dart';
import 'package:paytel/repositories/auth.repository.dart';


class MeBloc extends Bloc<MeEvent, MeState> {
  final UserRepository userRepository;

  MeBloc({required this.userRepository}) : super(MeInitial()){
     on<StartFetchMe>((event, emit) async {
        emit(MeLoading());
        try {
          final  response = await userRepository.me();
            if(response.data['status']){
              emit(MeSuccess(MeModel.fromJson(response.data["result"])));
            }else{
              emit(MeFailure(error: response.data["message"] ?? "خطا در ورود رخ داده است"));   
          }
        } catch (e) {
          emit(MeFailure( error: e.toString()));
        }
      });
  }

  
}