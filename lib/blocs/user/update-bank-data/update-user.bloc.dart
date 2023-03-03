import 'package:bloc/bloc.dart';
import 'package:paytel/blocs/user/update-bank-data/update-user.event.dart';
import 'package:paytel/blocs/user/update-bank-data/update-user.state.dart';
import 'package:paytel/repositories/auth.repository.dart';


class UpdateBankr extends Bloc<UpdateBankrEvent, UpdateBankrState> {
  UserRepository userRepository;
  UpdateBankr({required this.userRepository}) : super(UpdateBankrInitial()){
      on<UpdateBankrButtonPressed>((event, emit) async {
        emit(UpdateBankrLoading());
        try {
          final  response = await userRepository.updateBank(
                event.card,
                event.sheba,
            );
            if(response.data['status'] == true ){
                  emit(UpdateBankrSuccess());
            }else{
              emit(UpdateBankrFailure(error: response.data["message"] ?? "خطا در ورود رخ داده است"));   
          }
        } catch (e) {
          emit(UpdateBankrFailure( error: e.toString()));
        }
      });
    }
  }