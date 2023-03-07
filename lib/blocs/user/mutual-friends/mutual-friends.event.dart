// ignore: import_of_legacy_library_into_null_safe
import 'package:equatable/equatable.dart';

abstract class MutualFriendsEvent extends Equatable {
  const MutualFriendsEvent();

  @override
  List<Object> get props => [];
}

class MutualFriendsButtonPressed extends MutualFriendsEvent {
  final List<String> listOfContacts;

  const MutualFriendsButtonPressed({
    required this.listOfContacts,
  });

  @override
  List<Object> get props => [listOfContacts];

  @override
  String toString() =>
      'MutualFriendsButtonPressed ';
}
class GetAllMutualFriendsButtonPressed extends MutualFriendsEvent {

  const GetAllMutualFriendsButtonPressed();

  @override
  List<Object> get props => [];

  @override
  String toString() =>
      'MutualFriendsButtonPressed ';
}
class DeleteMutualFriendsButtonPressed extends MutualFriendsEvent {
  final String id;

  const DeleteMutualFriendsButtonPressed({
    required this.id,
  });

  @override
  List<Object> get props => [id];

  @override
  String toString() =>
      'MutualFriendsButtonPressed ';
}