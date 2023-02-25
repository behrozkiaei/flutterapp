import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:paytel/blocs/transaction/my-transaction/my-transactions.event.dart';
import 'package:paytel/blocs/transaction/my-transaction/my-transactions.state.dart';
import 'package:paytel/models/transaction/my-transactions.dart';
import 'package:paytel/repositories/transactions.repository.dart';


class MyTransactionsBloc extends Bloc<MyTransactionsEvent, MyTransactionsState> {
  TransactionRepo transactionRepository;
  MyTransactionsBloc({required this.transactionRepository}) : super(MyTransactionsInitial()){
       on<MyTransactionsButtonPressed>((event, emit) async {
        final currentState = state;
        
        emit(MyTransactionsLoading());
         
        try {
          final  response = await transactionRepository.getMyTransactions(
            event.page
            );

            if(response.data['status'] == true ){
     
               List<MyTransactions> transactionList = List.from(response.data['result']['data']).map((json) => MyTransactions.fromJson(json)).toList();
              if(currentState is MyTransactionsSuccess && event.page !=0){
              //   print(1);
                List<MyTransactions> listOfAll = List.from([...currentState.myTransactions, ...transactionList]);
                if(listOfAll.length  != response.data['result']['length']){
                  emit(MyTransactionsSuccess(listOfAll));
                }
              }else{
                emit(MyTransactionsSuccess(transactionList));
              }

            }else{
              emit(MyTransactionsFailure(error: response.data["message"] ?? "خطا در ورود رخ داده است"));   
          }
        } catch (e) {
          emit(MyTransactionsFailure( error: e.toString()));
        }
      });
    }
  }