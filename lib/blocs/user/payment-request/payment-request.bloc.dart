import 'package:bloc/bloc.dart';
import 'package:paytel/blocs/user/payment-request/payment-request.event.dart';
import 'package:paytel/blocs/user/payment-request/payment-request.state.dart';
import 'package:paytel/models/payment-requests-model.dart';
import 'package:paytel/repositories/transactions.repository.dart';


class PaymentRequestBloc extends Bloc<PaymentRequestEvent, PaymentRequestState> {
  TransactionRepo transactionRepo;
  PaymentRequestBloc({required this.transactionRepo}) : super(PaymentRequestInitial()){
      on<PaymentRequestButtonPressed>((event, emit) async {
        emit(PaymentRequestLoading());
        
        try {
          final  response = await transactionRepo.paymentRequest(
            event.amount,
            );
            if(response.data['status'] == true ){
                  emit(PaymentRequestSuccess());
            }else{
              emit(PaymentRequestFailure(error: response.data["message"] ?? "خطا در ورود رخ داده است"));   
          }
        } catch (e) {
          emit(PaymentRequestFailure( error: e.toString()));
        }
      });
  }
  }


  class DeletePaymentRequestBloc extends Bloc<PaymentRequestEvent, PaymentRequestState> {
  TransactionRepo transactionRepo;
  DeletePaymentRequestBloc({required this.transactionRepo}) : super(PaymentRequestInitial()){
   on<DeletePaymentRequestButtonPressed>((event, emit) async {
        emit(PaymentRequestLoading());
        try {
          final  response = await transactionRepo.deletepaymentRequest(event.id);
            if(response.data['status'] == true ){
                  emit(PaymentRequestSuccess());
            }else{
              emit(PaymentRequestFailure(error: response.data["message"] ?? "خطا در ورود رخ داده است"));   
          }
        } catch (e) {
          emit(PaymentRequestFailure( error: e.toString()));
        }
      });
    }
  }

  class PaymentRequestListBloc extends Bloc<PaymentRequestEvent, PaymentRequestState> {
  TransactionRepo transactionRepo;
  PaymentRequestListBloc({required this.transactionRepo}) : super(PaymentRequestInitial()){
      on<GetAllPaymentRequestButtonPressed>((event, emit) async {
        emit(PaymentRequestLoading()); 
        try {

          final  response = await transactionRepo.paymentRequestList();

            if(response.data['status'] == true ){
                  List<PaymentRequestModel> data = List.from(response.data['result']).map((json) => PaymentRequestModel.fromJson(json)).toList();
                  emit( PaymentRequestListSuccess(data));

            }else{
              emit(PaymentRequestFailure(error: response.data["message"] ?? "خطا در ورود رخ داده است"));   

          }
        } catch (e) {
          emit(PaymentRequestFailure( error: e.toString()));
        }
      });
  }
}
