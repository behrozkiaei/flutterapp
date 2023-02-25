// ignore: import_of_legacy_library_into_null_safe
import 'package:equatable/equatable.dart';

abstract class AppStateEvent extends Equatable {
  const AppStateEvent();

  @override
  List<Object> get props => [];
}

class ChangeThemeColor extends AppStateEvent {
  @override
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
  @override
  final bool authenticated;

   const AthenticationChanged({
    required this.authenticated
  });
  List<Object> get props => [authenticated];

  @override
  String toString() =>
      'ChangeThemeColor ';
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