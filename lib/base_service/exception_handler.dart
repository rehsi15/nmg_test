import 'dart:async';
import 'dart:io';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';


class ExceptionHandlers {

  getExceptionString(error) {
    if (error is SocketException) {
      return 'No internet connection.';
    } else if (error is HttpException) {
      return 'HTTP error occurred.';
    } else if (error is FormatException) {
      return 'Data format Exception.';
    } else if (error is TimeoutException) {
      return 'Request timeout.';
    } else if (error is BadRequestException) {
      return error.message.toString();
    } else if (error is UnAuthorizedException) {
      return error.message.toString();
    }
    else if (error is BadGatewayException) {
      return error.message.toString();
    }
    else if (error is ServerDownException) {
      return error.message.toString();
    }
    else if (error is SocketException) {
      return error.message.toString();
    }
    else if (error is NotFoundException) {
      return error.message.toString();
    } else if (error is FetchDataException) {
      return error.message.toString();
    } else if (error is InternalServerException) {
      return error.message.toString();
    }
    else {
      return 'Unable to connect please try again';
    }
  }
}

class AppException implements Exception {
  final String? message;
  final String? prefix;
  final String? url;

  AppException([this.message, this.prefix, this.url]);

}

class BadRequestException extends AppException {
  BadRequestException([String? message, String? url])
      : super(message, 'Bad request', url);
}

class FetchDataException extends AppException {
  FetchDataException([String? message, String? url])
      : super(message, 'Unable to process the request', url);
}

class ApiNotRespondingException extends AppException {
  ApiNotRespondingException([String? message, String? url])
      : super(message, 'Api not responding', url);
}

class UnAuthorizedException extends AppException {
  UnAuthorizedException([String? message, String? url])
      : super(message, 'Unauthorized request', url);
}


class BadGatewayException extends AppException {
  BadGatewayException([String? message, String? url])
      : super(message, 'BadGateway', url);
}


class ServerDownException extends AppException {
  ServerDownException([String? message, String? url])
      : super(message, 'Server Down please try after sometime', url);
}

class SocketException extends AppException {
  SocketException([String? message, String? url])
      : super(message, 'No Internet', url);
}

class NotFoundException extends AppException {
  NotFoundException([String? message, String? url])
      : super(message, 'Page not found', url);
}

class InternalServerException extends AppException{
  InternalServerException([String? message, String? url])
      : super(message, 'Page not found', url);
}