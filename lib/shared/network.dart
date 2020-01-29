import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:wheater_app/shared/shared.dart';

class Network extends Object  {
  Dio _dio;

  Network() {
    BaseOptions options = new BaseOptions(
        baseUrl: BaseConfig.baseUrl,
        connectTimeout: 5000,
        receiveTimeout: 3000,
        headers: null);
    this._dio = Dio(options);
    this._dio.interceptors.add(PrettyDioLogger());
  }

  Future<Map<String,dynamic>> getHttp(String path, Map<String, dynamic> parameter) async{
    try{
      parameter.addAll({'appid': BaseConfig.apiKey});
      Response response =  await _dio.get(path, queryParameters: parameter);
      return response.data;
    } catch(e){
      print('error $e');
      throw Exception(e);
    }
  }

  forTesting({@required Dio dio}) {
    this._dio = dio;
  }
}

final network = Network();
