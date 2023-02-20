import 'package:bloc/bloc.dart';
import 'package:paytel/blocs/user/update-national-card/update-avatar.event.dart';
import 'package:paytel/blocs/user/update-national-card/update-avatar.state.dart';
import 'package:paytel/repositories/auth.repository.dart';


class UpdateNationalCard extends Bloc<UpdateNationalCardEvent, UpdateNationalCardState> {
  UserRepository userRepository;
  UpdateNationalCard({required this.userRepository}) : super(UpdateNationalCardInitial()){
      on<UpdateNationalCardButtonPressed>((event, emit) async {
        emit(UpdateNationalCardLoading());
        try {
          final  response = await userRepository.updateNationalCard(
            event.cartMelli,
            );
            if(response.data['result'] != false ){
                  emit(UpdateNationalCardSuccess());
            }else{
              emit(UpdateNationalCardFailure(error: response.data["message"] ?? "خطا در ورود رخ داده است"));   
          }
        } catch (e) {
            print(e);
          emit(UpdateNationalCardFailure( error: e.toString()));
        }
      });
    }
  }