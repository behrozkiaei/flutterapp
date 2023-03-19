import 'package:bloc/bloc.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:paytel/blocs/user/mutual-friends/mutual-friends.event.dart';
import 'package:paytel/blocs/user/mutual-friends/mutual-friends.state.dart';
import 'package:paytel/models/mutual-friends-payload.dart';
import 'package:paytel/models/mutual-friends.model.dart';
import 'package:paytel/repositories/auth.repository.dart';


class MutualFriendsBloc extends Bloc<MutualFriendsEvent, MutualFriendsState> {
  UserRepository userRepository;
  MutualFriendsBloc({required this.userRepository}) : super(MutualFriendsInitial()){
      on<MutualFriendsButtonPressed>((event, emit) async {
        emit(MutualFriendsLoading());
        
        try {
          List<ContactImpl> listOfUsersExpanded = ContactImpl.expandAllByPhones(event.listOfContacts)  ;  
          String contactMaps =  ContactImpl.contactsToJson(listOfUsersExpanded);
          final  response = await userRepository.mutualFriends(
            contactMaps,
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


String getPhoneNumbersString(List<String> contact) {
  return 'list=${contact.join(",list=")}';
}
List<String> getAllPhoneNumbers(List<Contact> contacts) {
  return contacts
      .map((contact) => contact.phones) // map each contact to its list of phones
      .expand((phones) => phones) // flatten the list of lists
      .toList(); // convert the result to a list
}