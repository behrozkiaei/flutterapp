
import 'package:dio/dio.dart';
import 'package:paytel/const.dart';
import 'package:paytel/repositories/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
class UserRepository {
static final UserRepository _instance = UserRepository._internal();

  factory UserRepository() {
    return _instance;
  }

  UserRepository._internal();
  
static BaseOptions options = BaseOptions(
  baseUrl: Config.baseUrl,
  headers: {'Content-Type': 'application/json' ,}
  );
  final Dio _dio = DioSingleton.dio;
  String? token ;
  Future<bool> hasToken() async {
    final prefs = await SharedPreferences.getInstance();
    final String? value = prefs.getString("token");
    if (value != null) {
      return true;
    } else {
      return false;
    }
  }

  static Future<void> persistToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }
  static Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }
  static Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.clear();
  }

    Future<Response> sendOtp(String mobile ,String otpType) async {
       Response response = await _dio.post('/auth/signIn', data:{ "mobile": mobile ,"otpType":otpType});
       return response;
    }
     Future<Response> verifyOtp(String mobile, String password) async {
       final prefs = await SharedPreferences.getInstance();
        final String? fcm =  prefs.getString('fcmToken');
        print(fcm);
        print(888888888888);
      Response response = await _dio.post('/auth/verify-otp', data: {
        "mobile": mobile,
        "password": password,
        'fcmToken' : fcm
      });
      return response;
    }

    Future<Response> me() async {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");
      print(token);
      _dio.options.headers["Authorization"] = "Bearer $token";
      Response response = await _dio.get('/users/me');
      return response;
    }


    Future<Response> updateUser(
      String? username ,
      String? name,
      String? address,
      String? description,
      String? email,
      String? lat,
      String? lan,
      String? nationalCode,
      ) async {
      final token = await getToken();
      _dio.options.headers["Authorization"] = "Bearer $token";
       Response response = await _dio.patch('/users/update-user', data:{ 
          'username' :username,
          'name' : name,
          'address' : address,
          'description' : description,
          'email' : email,
          'nationalCode' : nationalCode,
          'lat' :lat ,
          'lan': lan,
        });
       return response;
    }
    Future<Response> updateAvatar(String avatar) async {
      final token = await getToken();
      _dio.options.headers["Authorization"] = "Bearer $token";
       Response response = await _dio.patch('/users/update-avatar', data:{ 
          'avatar' :avatar,
        });
       return response;
    }


    Future<Response> updateNationalCard(
      String cartMelli ) async {
       final token = await getToken();
       _dio.options.headers["Authorization"] = "Bearer $token";
       Response response = await _dio.patch('/users/update-cartmaelli', data:{ 
          'cartMelli' :cartMelli,
        });
       return response;
    }

     Future<Response> updateIdentityImage(
      String shenasname ) async {
        final token = await getToken();
        _dio.options.headers["Authorization"] = "Bearer $token";
       Response response = await _dio.patch('/users/update-shenasname', data:{ 
          'shenasname' :shenasname,
        });
       return response;
    }

    Future<Response> updateBank(
      String sheba , String card ) async {
      final token = await getToken();
      _dio.options.headers["Authorization"] = "Bearer $token";
       Response response = await _dio.patch('/users/update-bank-account', data:{ 
          'sheba' :sheba,
          'card' :card,
        });
       return response;
    }

    Future<Response> setPass(String password) async {
      final prefs = await SharedPreferences.getInstance();
      final String? uid = prefs.getString("uid");
      final String? userId = prefs.getString("userId");
      Response response = await _dio.post('/auth/set-pass', data:{ 
          'uid' :uid,
          'userId' :userId,
          'password' :password,
        });
       return response;
    }
  Future<Response> checkPass(
      String password  ) async {
      final token = await getToken();
      _dio.options.headers["Authorization"] = "Bearer $token";
       Response response = await _dio.post('/users/check-pass', data:{ 
          'password' :password,
        });
       return response;
    }
    Future<Response> mutualFriends(
      String listOfstring  ) async {
      final token = await getToken();
      _dio.options.headers["Authorization"] = "Bearer $token";
       Response response = await _dio.post('/users/mutual-friends',data:listOfstring );
       return response;
    }
    Future<Response> lastPaidUsers(
      String listOfstring  ) async {
      final token = await getToken();
      _dio.options.headers["Authorization"] = "Bearer $token";
       Response response = await _dio.get('/users/last-paid-users' );
       return response;
    }

}