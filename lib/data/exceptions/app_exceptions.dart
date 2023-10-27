class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  String toString() {
    return '$_prefix$_message';
  }
}

class InternetException extends AppException {
  InternetException({String? message}) : super(message, 'No Internet');
}

class RequestTimeOut extends AppException {
  RequestTimeOut({String? message}) : super(message,'Request Time Out');
}

class ServerException extends AppException {
  ServerException({String? message}) : super(message,'Internal Server Error');
}

class InvalidExcemption extends AppException {
  InvalidExcemption({String? message}) : super(message,'Invalid Url');
}

class FetchDataExcemption extends AppException {
  FetchDataExcemption({String? message}) : super(message,'');
}