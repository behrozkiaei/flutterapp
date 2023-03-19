import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:paytel/blocs/app-state/app-state.event.dart';
import 'package:paytel/blocs/app-state/app-state.state.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AppStateBloc extends Bloc<AppStateEvent, AppStateState> {

  AppStateBloc() : super(AppStateState(tabIndex : 0 , themeMode: 'light',isAuthenticated: false,transactionPanelStateIsOpen :false,scannerPanelStateIsOpen: false)){
     
     on<ChangeThemeColor>((event, emit) async {
          final currentState = state;
          emit( currentState.copyWith(themeMode: event.themeMode));   

      });
      on<AthenticationChanged>((event, emit) async {
          final currentState = state;
          emit( currentState.copyWith(isAuthenticated: event.authenticated));   

      });
      on<PageIndex>((event, emit) async {
          final currentState = state;
          
          emit( currentState.copyWith(tabIndex: event.pageIndex));   

      });
      on<ChangeTransactionPanelState>((event, emit) async {
          final currentState = state;
          
          emit( currentState.copyWith(transactionPanelStateIsOpen: event.isTransactionPanelOpen));   

      });
      on<ChangeScannerPanelState>((event, emit) async {
          final currentState = state;
          emit( currentState.copyWith(scannerPanelStateIsOpen: event.isScannerPanelOpen));   
      });
       on<SaveToStorage>((event, emit) async {
          final currentState = state; 
          final instance = await SharedPreferences.getInstance();
          instance.setString('appState', json.encode(currentState.toJson()));
      });
      on<LoadFromStorage>((event, emit) async {
          final instance = await SharedPreferences.getInstance();
          final appStateString = instance.getString('appState');
          if(appStateString != null){
          emit(AppStateState.fromJson( json.decode(appStateString)));
          }else{
            AppStateState(tabIndex : 0 , themeMode: 'light' , isAuthenticated: false);
          }
      });
  }

  
}