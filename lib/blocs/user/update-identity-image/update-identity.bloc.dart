import 'package:bloc/bloc.dart';
import 'package:paytel/blocs/user/update-identity-image/update-identity.event.dart';
import 'package:paytel/blocs/user/update-identity-image/update-identity.state.dart';
import 'package:paytel/repositories/auth.repository.dart';


class UpdateIdentityImage extends Bloc<UpdateIdentityImageEvent, UpdateIdentityImageState> {
  UserRepository userRepository;
  UpdateIdentityImage({required this.userRepository}) : super(UpdateIdentityImageInitial()){
      on<UpdateIdentityImageButtonPressed>((event, emit) async {
        emit(UpdateIdentityImageLoading());
        try {
          final  response = await userRepository.updateIdentityImage(
            event.shenasname,
            );
            if(response.data['status'] == true ){
                  emit(UpdateIdentityImageSuccess());
            }else{
              emit(UpdateIdentityImageFailure(error: response.data["message"] ?? "خطا در ورود رخ داده است"));   
          }
        } catch (e) {
            print(e);
          emit(UpdateIdentityImageFailure( error: e.toString()));
        }
      });
    }
  }