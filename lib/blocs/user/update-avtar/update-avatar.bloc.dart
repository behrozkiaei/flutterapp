import 'package:bloc/bloc.dart';
import 'package:paytel/blocs/user/update-avtar/update-avatar.event.dart';
import 'package:paytel/blocs/user/update-avtar/update-avatar.state.dart';
import 'package:paytel/repositories/auth.repository.dart';


class UpdateAvatar extends Bloc<UpdateAvatarEvent, UpdateAvatarState> {
  UserRepository userRepository;
  UpdateAvatar({required this.userRepository}) : super(UpdateAvatarInitial()){
      on<UpdateAvatarButtonPressed>((event, emit) async {
        emit(UpdateAvatarLoading());
        
        try {
          final  response = await userRepository.updateAvatar(
            event.avatar,
            );
            if(response.data['status'] == true ){
                  emit(UpdateAvatarSuccess());
            }else{
              emit(UpdateAvatarFailure(error: response.data["message"] ?? "خطا در ورود رخ داده است"));   
          }
        } catch (e) {
          emit(UpdateAvatarFailure( error: e.toString()));
        }
      });
    }
  }