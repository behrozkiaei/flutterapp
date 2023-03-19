// ignore: import_of_legacy_library_into_null_safe
import 'package:equatable/equatable.dart';

abstract class AppStateEvent extends Equatable {
  const AppStateEvent();

  @override
  List<Object> get props => [];
}

class ChangeThemeColor extends AppStateEvent {
 

  final String themeMode;

   const ChangeThemeColor({
    required this.themeMode
  });
  List<Object> get props => [themeMode];

  @override
  String toString() =>
      'ChangeThemeColor ';
}

class AthenticationChanged extends AppStateEvent {
 
  final bool authenticated;

   const AthenticationChanged({
    required this.authenticated
  });
  List<Object> get props => [authenticated];

  @override
  String toString() =>
      'ChangeThemeColor ';
}
class ChangeTransactionPanelState extends AppStateEvent {
 
  final bool isTransactionPanelOpen;

   const ChangeTransactionPanelState({
    required this.isTransactionPanelOpen
  });
  List<Object> get props => [isTransactionPanelOpen];
}
class ChangeScannerPanelState extends AppStateEvent {
 
  final bool isScannerPanelOpen;

   const ChangeScannerPanelState({
    required this.isScannerPanelOpen
  });
  List<Object> get props => [isScannerPanelOpen];
}

class PageIndex extends AppStateEvent {
  @override
  final int pageIndex;

   const PageIndex({
    required this.pageIndex
  });
  List<Object> get props => [pageIndex];

  @override
  String toString() =>
      'ChangeThemeColor ';
}


class SaveToStorage extends AppStateEvent {}
class LoadFromStorage extends AppStateEvent {}