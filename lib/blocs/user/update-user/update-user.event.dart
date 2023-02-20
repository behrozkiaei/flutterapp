// ignore: import_of_legacy_library_into_null_safe
import 'package:equatable/equatable.dart';

abstract class UpdateUserEvent extends Equatable {
  const UpdateUserEvent();

  @override
  List<Object> get props => [];
}

class UpdateUserButtonPressed extends UpdateUserEvent {
  final String? username;
  final String? name;
  final String? address;
  final String? description;
  final String? email;
  final String? lat;
  final String? lan;

  const UpdateUserButtonPressed({
     this.username,
     this.name,
     this.address,
     this.description,
     this.email,
     this.lat,
     this.lan,
  });

  @override
  List<Object> get props => [];

  @override
  String toString() =>
      'UpdateUserButtonPressed { email: , password:  }';
}