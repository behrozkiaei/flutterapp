import 'package:bloc/bloc.dart';
import 'package:paytel/repositories/auth.repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'check-pass.event.dart';
import 'check-pass.state.dart';


class CheckPassBloc extends Bloc<CheckPassEvent, CheckPassState> {
  UserRepository userRepository;

  CheckPassBloc({required this.userRepository}) : super(CheckPassInitial()){
    on<CheckPassButtonPressed>((event, emit) async {
      emit(CheckPassLoading());
      try {

       final  response = await userRepository.checkPass(
         event.password
        );
        if(response.data['status']){
          final prefs = await SharedPreferences.getInstance();
          prefs.setString("password", event.password);
          emit(CheckPassSuccess());
        }else{
          emit(CheckPassFailure(error: response.data["message"] ?? "خطا در ورود رخ داده است"));   
       }
      } catch (e) {
        emit(CheckPassFailure( error: e.toString()));
      }
    });
  }

  
}