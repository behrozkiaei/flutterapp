// ignore: import_of_legacy_library_into_null_safe
import 'package:equatable/equatable.dart';

abstract class LastPaidUsersEvent extends Equatable {
  const LastPaidUsersEvent();

  @override
  List<Object> get props => [];
}

class LastPaidUsersButtonPressed extends LastPaidUsersEvent {
  final List<String> listOfContacts;

  const LastPaidUsersButtonPressed({
    required this.listOfContacts,
  });

  @override
  List<Object> get props => [listOfContacts];

  @override
  String toString() =>
      'LastPaidUsersButtonPressed ';
}
class GetAllLastPaidUsersButtonPressed extends LastPaidUsersEvent {

  const GetAllLastPaidUsersButtonPressed();

  @override
  List<Object> get props => [];

  @override
  String toString() =>
      'LastPaidUsersButtonPressed ';
}
class DeleteLastPaidUsersButtonPressed extends LastPaidUsersEvent {
  final String id;

  const DeleteLastPaidUsersButtonPressed({
    required this.id,
  });

  @override
  List<Object> get props => [id];

  @override
  String toString() =>
      'LastPaidUsersButtonPressed ';
}