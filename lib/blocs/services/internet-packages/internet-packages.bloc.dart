import 'package:bloc/bloc.dart';
import 'package:paytel/blocs/services/internet-packages/internet-packages.event.dart';
import 'package:paytel/blocs/services/internet-packages/internet-packages.state.dart';
import 'package:paytel/models/internet-packages-model.model.dart';
import 'package:paytel/repositories/transactions.repository.dart';


class InternetPackagesBloc extends Bloc<InternetPackagesEvent, InternetPackagesState> {
  TransactionRepo transactionRepository;
  InternetPackagesBloc({required this.transactionRepository}) : super(InternetPackagesInitial()){
       on<InternetPackagesButtonPressed>((event, emit) async {
        emit(InternetPackagesLoading());
        try {
          final  response = await transactionRepository.getInternetPackages();
            if(response.data['status'] == true ){
               List<InternetPackagesModel> internetPackages = List.from(response.data['result']).map((json) => InternetPackagesModel.fromJson(json)).toList();
                emit(InternetPackagesSuccess(internetPackages));
            }else{

             throw Exception(response.data['message']);
             }
        } catch (e) {
          emit(InternetPackagesFailure( error: e.toString()));
        }
      });
    }
  }