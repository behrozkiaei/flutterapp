
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
      _dio.options.headers["Authorization"] = "Bearer $token";
      Response response = await _dio.post('/wallet/user-transfer', data:{ 
        "amount" :amount,
        "walletCode" : walletCode
      });
      return response;
  }


   Future<Response> getMyTransactions( int page ) async {
      var from = page * 10 ;
      print(555555555555555);
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");
      print(token);
      _dio.options.headers["Authorization"] = "Bearer $token";
      Response response = await _dio.get('/transaction/get-all-orders/?from=$from&take=10');
      return response;
  }
  Future<Response> getInternetPackages(  ) async {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");
      _dio.options.headers["Authorization"] = "Bearer $token";
      Response response = await _dio.get('/Services/getInternetPackages');
      return response;
  }
  Future<Response> buyInternet( {
    required String productId ,
    required String mobile ,
    required String simType ,
    required bool fromWallet ,
    required String internetPayloadOperator ,
   }) async {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");
      _dio.options.headers["Authorization"] = "Bearer $token";
      Response response = await _dio.post('/transaction/buyInternet',data:{
        "product_id": productId,
        "mobile": mobile,
        "sim_type":  simType,
        "fromWallet":  fromWallet ,
        "operator": internetPayloadOperator,
      });
      return response;
  }
   Future<Response> buyCharge( {
    required bool fromWallet ,
    required String chargePayloadOperator ,
    required String amount ,
    required String mobile ,
    required String chargeType,
   } ) async {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");
      _dio.options.headers["Authorization"] = "Bearer $token";
      Response response = await _dio.post('/transaction/buyCharge',data: {
      "fromWallet":fromWallet ,
      "operator":chargePayloadOperator  ,
      "amount":amount ,
      "mobile":mobile  ,
      "chargeType": chargeType ,
      });
      return response;
  }

  
     Future<Response> paymentRequestList( ) async {
      final token = await getToken();
      _dio.options.headers["Authorization"] = "Bearer $token";
       Response response = await _dio.get('/payment-request');
       return response;
    }
    Future<Response> paymentRequest(
      String amount  ) async {
      final token = await getToken();
      _dio.options.headers["Authorization"] = "Bearer $token";
       Response response = await _dio.post('/payment-request',data:{
        'amount': amount
       });
       return response;
    }
    Future<Response> deletepaymentRequest(
      String id  ) async {
      final token = await getToken();
      _dio.options.headers["Authorization"] = "Bearer $token";
       Response response = await _dio.delete('/payment-request/$id');
       return response;
    }
}