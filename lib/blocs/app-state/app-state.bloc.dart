import 'package:bloc/bloc.dart';
import 'package:paytel/blocs/app-state/app-state.event.dart';
import 'package:paytel/blocs/app-state/app-state.state.dart';
import 'package:paytel/models/app-state.model.dart';
import 'package:paytel/repositories/auth.repository.dart';


class AppStateBloc extends Bloc<AppStateEvent, AppStateState> {
  final UserRepository userRepository;

  AppStateBloc({required this.userRepository}) : super(AppStateInitial()){
     on<ChangeThemeColor>((event, emit) async {
          emit( AppStateSuccess(AppState.fromJson({"themeMode" : event.themeMode})));   

      });
      on<AthenticationChanged>((event, emit) async {
            emit( AppStateSuccess(AppState.fromJson({"authenticated" : event.authenticated})));    

      });
      on<PageIndex>((event, emit) async {
          emit(AppStateSuccess(AppState.fromJson({"pageIndex" : event.pageIndex})));   

      });
  }

  
}