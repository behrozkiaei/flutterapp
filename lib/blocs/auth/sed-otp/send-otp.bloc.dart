import 'package:bloc/bloc.dart';
import 'package:paytel/blocs/auth/sed-otp/send-otp.event.dart';
import 'package:paytel/blocs/auth/sed-otp/send-otp.state.dart';
import 'package:paytel/repositories/auth.repository.dart';
import 'package:paytel/widgets/utils/enums.dart';


class SendOtpBloc extends Bloc<SendOtpEvent, SendOtpState> {
  UserRepository userRepository;

  SendOtpBloc({required this.userRepository}) : super(SendOtpInitial()){
    on<SendOtpButtonPressed>((event, emit) async {
       String? otpType;
      if(state is SendOtpRessetPass){
         otpType = OtpType.RessetPass.name;
      } else{
        otpType = OtpType.Login.name;
      }
      emit(SendOtpLoading());
      try {

       final  response = await userRepository.sendOtp(
         event.mobile,
         otpType
        );
        if(response.data['status']){
          emit(SendOtpSuccess());
        }else{
          emit(SendOtpFailure(error: response.data["message"] ?? "خطا در ورود رخ داده است"));   
       }
      } catch (e) {
        emit(SendOtpFailure( error: e.toString()));
      }
    });
    on<SendOtpRessetPassButtonPressed>((event, emit) async {
      emit(SendOtpRessetPass());
    });
  }

  
}