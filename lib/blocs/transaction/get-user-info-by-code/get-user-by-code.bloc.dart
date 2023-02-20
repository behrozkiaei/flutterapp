import 'package:bloc/bloc.dart';
import 'package:paytel/blocs/transaction/get-user-info-by-code/get-user-by-code.event.dart';
import 'package:paytel/blocs/transaction/get-user-info-by-code/get-user-by-code.state.dart';
import 'package:paytel/models/transaction/users-by-code-model.dart';
import 'package:paytel/repositories/transactions.repository.dart';


class UserByCodeBloc extends Bloc<UserByCodeEvent, UserByCodeState> {
  TransactionRepo transactionRepository;
  UserByCodeBloc({required this.transactionRepository}) : super(UserByCodeInitial()){
      on<UserByCodeButtonPressed>((event, emit) async {
        emit(UserByCodeLoading());
        try {
          final  response = await transactionRepository.getWalletDataByCode(
            event.code
            );
            print(response.data);
            if(response.data['status'] == true ){
                  emit(UserByCodeSuccess(UserByCode.fromJson(response.data['result']).copyWith(code: event.code)));
            }else{
              emit(UserByCodeFailure(error: response.data["message"] ?? "خطا در ورود رخ داده است"));   
          }
        } catch (e) {
          print(e.toString());
          emit(UserByCodeFailure( error: e.toString()));
        }
      });
    }
  }