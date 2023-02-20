import 'package:bloc/bloc.dart';
import 'package:paytel/blocs/transaction/wallet-to-wallet-transfer/wallet2wallet.event.dart';
import 'package:paytel/blocs/transaction/wallet-to-wallet-transfer/wallet2wallet.state.dart';
import 'package:paytel/repositories/transactions.repository.dart';


class Wallet2WalletBloc extends Bloc<Wallet2WalletEvent, Wallet2WalletState> {
  TransactionRepo transactionRepository;
  Wallet2WalletBloc({required this.transactionRepository}) : super(Wallet2WalletInitial()){
      on<Wallet2WalletButtonPressed>((event, emit) async {
        emit(Wallet2WalletLoading());
        print(event.walletCode);
        print(event.amount);
        try {
          print(7);
          final  response = await transactionRepository.wallet2WalletTransfer(
            event.amount,
            event.walletCode
            );
            print(response.data);
            if(response.data['status'] == true ){
                  emit(Wallet2WalletSuccess());
            }else{
              print(3);
              emit(Wallet2WalletFailure(error: response.data["message"] ?? "خطا در ورود رخ داده است"));   
          }
        } catch (e) {
          print(4);
          emit(Wallet2WalletFailure( error: e.toString()));
        }
      });
    }
  }