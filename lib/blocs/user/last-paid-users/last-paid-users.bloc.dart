import 'package:bloc/bloc.dart';
import 'package:paytel/blocs/user/last-paid-users/last-paid-users.event.dart';
import 'package:paytel/blocs/user/last-paid-users/last-paid-users.state.dart';
import 'package:paytel/models/mutual-friends.model.dart';
import 'package:paytel/repositories/auth.repository.dart';


class LastPaidUsersBloc extends Bloc<LastPaidUsersEvent, LastPaidUsersState> {
  UserRepository userRepository;
  LastPaidUsersBloc({required this.userRepository}) : super(LastPaidUsersInitial()){
      on<LastPaidUsersButtonPressed>((event, emit) async {
        emit(LastPaidUsersLoading());
        
        try {
          final  response = await userRepository.lastPaidUsers(
            event.listOfContacts.toString(),
            );
            if(response.data['status'] == true ){
                List<MutualFriendsModel> data = List.from(response.data['result']).map((json) => MutualFriendsModel.fromJson(json)).toList();
                emit( LastPaidUsersListSuccess(data));
            }else{
              emit(LastPaidUsersFailure(error: response.data["message"] ?? "خطا در ورود رخ داده است"));   
          }
        } catch (e) {
          emit(LastPaidUsersFailure( error: e.toString()));
        }
      });
  }
  }

