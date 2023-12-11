import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get_connect/connect.dart';

import 'exception_handler.dart';

class BaseService extends GetConnect {

  @override
  void onInit() {

    ///1.base_url
    httpClient.baseUrl = "https://jsonplaceholder.typicode.com/";
    //2.
    httpClient.defaultContentType = "application/json";

    httpClient.timeout = const Duration(seconds: 20);
    //httpClient.maxAuthRetries = 3;

    httpClient.addAuthenticator<dynamic>((request) async {
      //request.headers.addAll(headers);
      request.headers['Authorization'] =  "";
      return request;
    });

    httpClient.addResponseModifier((request, response) async {
      print("response ${request.url}");
      print("response ${response.status.code}");
      print("response ${response.body}");

      return response;
    });

    httpClient.addRequestModifier<dynamic>((request) async {


      request.headers['Authorization'] = "Bearer ";

      print("request ${request.url}");
      print("request ${request.method}");
      print("request ${request.headers}");

      return request;
    });

    super.onInit();
  }

  /// for get requests.
  Future<dynamic> getRequest(String url,{Map<String,dynamic>? query}) async {
    Response? res;
    debugPrint(url);
    try {
      res = await get(url,query: query).timeout(const Duration(seconds: 25));
     return responseHandler(res);
    }

    catch (e) {
      throw ExceptionHandlers().getExceptionString(e);
    }
  }

  /// for post requests.
  Future<Response>postRequest(String url,dynamic body) async {
    Response? res;
    try {
      res = await post(url,body).timeout(const Duration(seconds: 25));
      return responseHandler(res);
    }
    catch (e) {
      throw ExceptionHandlers().getExceptionString(e);
    }
  }

  /// for patch requests.
  patchRequest(String url, dynamic body,{Map<String,dynamic>? query}) async {

    Response? res;
    try {
      res = await patch(url,body,query:query).timeout(const Duration(seconds: 20));
      return responseHandler(res);
    }
    catch (e) {
      throw ExceptionHandlers().getExceptionString(e);
    }
  }


  /// for put requests.
  putRequest(String url,{Map<String,dynamic>? query}) async {
    Response? res;
    debugPrint(url);
    try {
      res = await put(url,{query: query}).timeout(const Duration(seconds: 25));
      return responseHandler(res);

    }
     catch (e) {

      throw ExceptionHandlers().getExceptionString(e);
    }

  }

  /// for delete requests.
  deleteRequest(String url) async {
    Response? res;
    try {
      res = await delete(url);
      return responseHandler(res);
      // return res;
    }

    catch (e) {
      throw ExceptionHandlers().getExceptionString(e);
    }
  }

  dynamic responseHandler(Response response) {
    switch (response.statusCode) {
      case 200:
        return response;
      case 201:
      return response;
      case 400:
        var message = response.body['message'];
        throw BadRequestException(message);
      default:
        throw 'Error occurred retry';
    }
  }

}
