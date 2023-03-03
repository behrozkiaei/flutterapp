import 'package:bloc/bloc.dart';
import 'package:paytel/blocs/transaction/increase-wallet/increase-wallet.event.dart';
import 'package:paytel/blocs/transaction/increase-wallet/increase-wallet.state.dart';
import 'package:paytel/models/transaction/bank-url-model.dart';
import 'package:paytel/repositories/transactions.repository.dart';


class IncreaseWalletBloc extends Bloc<IncreaseWalletEvent, IncreaseWalletState> {
  TransactionRepo transactionRepository;
  IncreaseWalletBloc({required this.transactionRepository}) : super(IncreaseWalletInitial()){
      on<IncreaseWalletButtonPressed>((event, emit) async {
        emit(IncreaseWalletLoading());
        try {
          final  response = await transactionRepository.increaseWallet(
            event.amount
          );
            if(response.data['result'] != false ){
              emit(IncreaseWalletSuccess(BankUrl.fromJson(response.data['result'])));
            }else{
              emit(IncreaseWalletFailure(error: response.data["message"] ?? "خطا در ورود رخ داده است"));   
          }
        } catch (e) {

          emit(IncreaseWalletFailure( error: e.toString()));
        }
      });
    }
  }