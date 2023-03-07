// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:equatable/equatable.dart';
import 'package:paytel/models/mutual-friends.model.dart';

abstract class MutualFriendsState extends Equatable {
  const MutualFriendsState();

  @override
  List<Object> get props => [];
}

class MutualFriendsInitial extends MutualFriendsState {}

class MutualFriendsLoading extends MutualFriendsState {}
class MutualFriendsSuccess extends MutualFriendsState {
}
class MutualFriendsListSuccess extends MutualFriendsState {

  final  List<MutualFriendsModel> mutualFriends ;
  const MutualFriendsListSuccess(this.mutualFriends);
}

class MutualFriendsFailure extends MutualFriendsState {
  final String error;

  const MutualFriendsFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'MutualFriendsFailure { error: $error }';
}