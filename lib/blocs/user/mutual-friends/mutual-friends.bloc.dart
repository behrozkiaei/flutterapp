import 'package:bloc/bloc.dart';
import 'package:paytel/blocs/user/mutual-friends/mutual-friends.event.dart';
import 'package:paytel/blocs/user/mutual-friends/mutual-friends.state.dart';
import 'package:paytel/models/mutual-friends.model.dart';
import 'package:paytel/repositories/auth.repository.dart';


class MutualFriendsBloc extends Bloc<MutualFriendsEvent, MutualFriendsState> {
  UserRepository userRepository;
  MutualFriendsBloc({required this.userRepository}) : super(MutualFriendsInitial()){
      on<MutualFriendsButtonPressed>((event, emit) async {
        emit(MutualFriendsLoading());
        
        try {
          final  response = await userRepository.mutualFriends(
            event.listOfContacts.toString(),
            );
            if(response.data['status'] == true ){
                List<MutualFriendsModel> data = List.from(response.data['result']).map((json) => MutualFriendsModel.fromJson(json)).toList();
                emit( MutualFriendsListSuccess(data));
            }else{
              emit(MutualFriendsFailure(error: response.data["message"] ?? "خطا در ورود رخ داده است"));   
          }
        } catch (e) {
          emit(MutualFriendsFailure( error: e.toString()));
        }
      });
  }
  }

