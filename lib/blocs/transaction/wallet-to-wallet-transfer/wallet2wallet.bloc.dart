import 'package:bloc/bloc.dart';
import 'package:paytel/blocs/transaction/wallet-to-wallet-transfer/wallet2wallet.event.dart';
import 'package:paytel/blocs/transaction/wallet-to-wallet-transfer/wallet2wallet.state.dart';
import 'package:paytel/repositories/transactions.repository.dart';


class Wallet2WalletBloc extends Bloc<Wallet2WalletEvent, Wallet2WalletState> {
  TransactionRepo transactionRepository;
  Wallet2WalletBloc({required this.transactionRepository}) : super(Wallet2WalletInitial()){
      on<Wallet2WalletButtonPressed>((event, emit) async {
        emit(Wallet2WalletLoading());
        try {
          final  response = await transactionRepository.wallet2WalletTransfer(
            event.amount,
            event.walletCode,
            event.fromWallet,
            );
            if(response.data['status'] == true ){
                  if(response.data["result"] != null){
                      emit( Wallet2WalletSuccess(RedirectURL : response.data["result"]["RedirectURL"] as String));
                  }
                  else{
                    emit(const Wallet2WalletSuccess());
                  }  
            }else{
              emit(Wallet2WalletFailure(error: response.data["message"] ?? "خطا در ورود رخ داده است"));   
            }
        } catch (e) {
          emit(Wallet2WalletFailure( error: e.toString()));
        }
      });
    }
  }