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
            if(response.data['result']["data"] != false ){

              final List<Map<String, dynamic>> jsonList = List<Map<String, dynamic>>.from(jsonDecode(response.data['result']["data"]));
              final List<MyTransactions> transactionList = jsonList.map((json) {
                final List<Map<String, dynamic>> descJson = List<Map<String, dynamic>>.from(json['desc']);
                final List<Desc> descList = descJson.map((descJson) => Desc.fromJson(descJson)).toList();
                return MyTransactions.fromJson(json).copyWith(descList as Map<dynamic, List<Desc>>);
              }).toList();
              if(currentState is MyTransactionsSuccess && event.page !=0){
                List<MyTransactions> listOfAll = List.from([...currentState.myTransactions, ...transactionList]);
                emit(MyTransactionsSuccess(listOfAll));
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