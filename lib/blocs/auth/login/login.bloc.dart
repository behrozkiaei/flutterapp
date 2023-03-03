import 'package:bloc/bloc.dart';
import 'package:paytel/blocs/auth/login/login.event.dart';
import 'package:paytel/blocs/auth/login/login.state.dart';
import 'package:paytel/models/TokenResponseModel.dart';
import 'package:paytel/repositories/auth.repository.dart';
import 'package:paytel/widgets/utils/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository userRepository;
  LoginBloc({required this.userRepository}) : super(LoginInitial()){
      on<LoginButtonPressed>((event, emit) async {
        emit(LoginLoading());
        try {
          final  response = await userRepository.verifyOtp(
            event.mobile,
            event.password
            );
            if(response.data['result'] != false ){
              final TokenResponseModel tokenObj = TokenResponseModel.fromJson(response.data['result']);
                if(tokenObj.otpType == OtpType.RessetPass.name ){
                         final prefs = await SharedPreferences.getInstance();
                         prefs.setString("uid",tokenObj.uid!);
                         prefs.setString("userId",tokenObj.userId!);
                        emit( LoginSuccess(otpType:tokenObj.otpType));
                }else if(tokenObj.token != null  ){
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setString("token" , tokenObj.token!);
                  emit( LoginSuccess(otpType:tokenObj.otpType));
                }else{
                   emit(const LoginFailure(error:  "خطا در ورود رخ داده است")); 
                }
                
            }else{

                emit(LoginFailure(error: response.data["message"] ?? "خطا در ورود رخ داده است"));   
          }
        } catch (e) {
          emit(LoginFailure( error: e.toString()));
        }
      });
  
    }
  }