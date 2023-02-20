
import 'package:dio/dio.dart';
import 'package:paytel/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
class TransactionRepo {
static final TransactionRepo _instance = TransactionRepo._internal();
  
  factory TransactionRepo() {
    getToken();
    return _instance;
  }

  TransactionRepo._internal();
  
static BaseOptions options = BaseOptions(
  baseUrl: Config.baseUrl,
  headers: {'Content-Type': 'application/json' ,}
  );
  final Dio _dio = Dio(options);
  String? token ;

  static Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  } 


  Future<Response> increaseWallet(
    String amount  ) async {
       final token = await getToken();
      _dio.options.headers["Authorization"] = "Bearer $token";
      Response response = await _dio.post('/wallet/user-increase-wallet', data:{ 
        "amount" :amount,
      });
      return response;
  }


  Future<Response> getWalletDataByCode(String id ) async {
      final token = await getToken();
      _dio.options.headers["Authorization"] = "Bearer $token";
      Response response = await _dio.get('/users/user-by-wallet-code/$id');
      return response;
  }


 
  Future<Response> wallet2WalletTransfer(
    String amount , String walletCode ) async {
       final token = await getToken();
       print(8);
       print(token);
      _dio.options.headers["Authorization"] = "Bearer $token";
      Response response = await _dio.post('/wallet/user-transfer', data:{ 
        "amount" :amount,
        "walletCode" : walletCode
      });
      return response;
  }


   Future<Response> getMyTransactions( int page ) async {
      var from = page * 10 ;
            final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");
      _dio.options.headers["Authorization"] = "Bearer $token";
      Response response = await _dio.get('/transaction/get-all-orders/?from=$from&take=10');
      return response;
  }

}