import 'package:bloc/bloc.dart';
import 'package:paytel/blocs/user/update-user/update-user.event.dart';
import 'package:paytel/blocs/user/update-user/update-user.state.dart';
import 'package:paytel/repositories/auth.repository.dart';


class UpdateUser extends Bloc<UpdateUserEvent, UpdateUserState> {
  UserRepository userRepository;
  UpdateUser({required this.userRepository}) : super(UpdateUserInitial()){
      on<UpdateUserButtonPressed>((event, emit) async {
        emit(UpdateUserLoading());
        try {
          final  response = await userRepository.updateUser(
                event.username,
                event.name,
                event.address,
                event.description,
                event.email,
                event.lat,
                event.lan,
                event.nationalCode,
            );
            if(response.data['status'] == true ){
                  emit(UpdateUserSuccess());
            }else{
              emit(UpdateUserFailure(error: response.data["message"] ?? "خطا در ورود رخ داده است"));   
          }
        } catch (e) {
            print(e);
          emit(UpdateUserFailure( error: e.toString()));
        }
      });
    }
  }