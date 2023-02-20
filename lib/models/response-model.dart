
import 'dart:convert';
class ResponseModel<T> {
    T? result;
    ResponseModel({
      this.result,
        this.status,
        this.message,
        this.statusCode,
    });

    bool? status;
    String? message;
    int? statusCode;

    
}
