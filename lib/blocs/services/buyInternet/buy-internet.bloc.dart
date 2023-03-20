import 'package:bloc/bloc.dart';
import 'package:paytel/blocs/services/buyInternet/buy-internet.event.dart';
import 'package:paytel/blocs/services/buyInternet/buy-internet.state.dart';
import 'package:paytel/repositories/transactions.repository.dart';


class BuyInternetBloc extends Bloc<BuyInternetEvent, BuyInternetState> {
  BuyInternetBloc({required this.transactionRepository}) : super(BuyInternetInitial()){
      on<BuyInternetButtonPressed>((event, emit) async {
        emit(BuyInternetLoading());
        try {
          final  response = await transactionRepository.buyInternet(
            productId :event.productId,
            mobile :event.mobile,
            simType: event.simType,
            fromWallet :event.fromWallet,
            internetPayloadOperator :event.InternetPayloadOperator ,
          );       
          if(response.data["status"] && event.fromWallet)  {
            emit(BuyInternetSuccess());   
          }   else          
          if(response.data["status"] && !event.fromWallet)  {
            emit(BuyInternetSuccess(RedirectURL : response.data["result"]["RedirectURL"]));   
          } else{
             throw Exception(response.data['message']);
          }

        } catch (e) {
          emit(BuyInternetFailure( error: e.toString()));
        }
      });
    }

  TransactionRepo transactionRepository;
}