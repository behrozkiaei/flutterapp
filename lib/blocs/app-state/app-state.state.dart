// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:equatable/equatable.dart';
import 'package:paytel/models/app-state.model.dart';

abstract class AppStateState extends Equatable {
  const AppStateState();

  @override
  List<Object> get props => [];
}

class AppStateInitial extends AppStateState {}

class AppStateLoading extends AppStateState {}

class AppStateSuccess extends AppStateState {
  final AppState appState ;

  const AppStateSuccess(this.appState); 

}



class AppStateFailure extends AppStateState {
  final String error;

  const AppStateFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'AppStateFailure { error: $error }';
}