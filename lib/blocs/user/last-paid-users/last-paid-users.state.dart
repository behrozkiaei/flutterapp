// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:equatable/equatable.dart';
import 'package:paytel/models/mutual-friends.model.dart';

abstract class LastPaidUsersState extends Equatable {
  const LastPaidUsersState();

  @override
  List<Object> get props => [];
}

class LastPaidUsersInitial extends LastPaidUsersState {}

class LastPaidUsersLoading extends LastPaidUsersState {}
class LastPaidUsersSuccess extends LastPaidUsersState {
}
class LastPaidUsersListSuccess extends LastPaidUsersState {

  final  List<MutualFriendsModel> lastPaidUsers ;
  const LastPaidUsersListSuccess(this.lastPaidUsers);
}

class LastPaidUsersFailure extends LastPaidUsersState {
  final String error;

  const LastPaidUsersFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LastPaidUsersFailure { error: $error }';
}