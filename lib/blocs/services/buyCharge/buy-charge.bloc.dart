import 'package:bloc/bloc.dart';
import 'package:paytel/blocs/services/buyCharge/buy-charge.event.dart';
import 'package:paytel/blocs/services/buyCharge/buy-charge.state.dart';
import 'package:paytel/repositories/transactions.repository.dart';


class BuyChargeBloc extends Bloc<BuyChargeEvent, BuyChargeState> {
  BuyChargeBloc({required this.transactionRepository}) : super(BuyChargeInitial()){
      on<BuyChargeButtonPressed>((event, emit) async {
        emit(BuyChargeLoading());
        try {
          final  response = await transactionRepository.buyCharge( 
            mobile: event.mobile ,
            fromWallet: event.fromWallet ,
            chargePayloadOperator:  event.chargePayloadOperator, 
            amount: event.amount,
            chargeType:event.chargeType, 
          );    
          if(response.data['status'] && !event.fromWallet)  {
            emit(BuyChargeSuccess(RedirectURL: response.data['status']['result']['RedirectURL']));   
          }  else          
          if(response.data['status'] && event.fromWallet)  {
            emit( BuyChargeSuccess());   
          }else{
             throw Exception(response.data['message']);
          }
          // throw Error(response.data['message'] ?? ''); 
        } catch (e) {
          emit(BuyChargeFailure( error: e.toString()));
        }
      });
    }

  TransactionRepo transactionRepository;
}