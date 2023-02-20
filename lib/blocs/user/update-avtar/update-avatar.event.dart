// ignore: import_of_legacy_library_into_null_safe
import 'package:equatable/equatable.dart';

abstract class UpdateAvatarEvent extends Equatable {
  const UpdateAvatarEvent();

  @override
  List<Object> get props => [];
}

class UpdateAvatarButtonPressed extends UpdateAvatarEvent {
  final String avatar;

  const UpdateAvatarButtonPressed({
    required this.avatar,
  });

  @override
  List<Object> get props => [avatar];

  @override
  String toString() =>
      'UpdateAvatarButtonPressed ';
}