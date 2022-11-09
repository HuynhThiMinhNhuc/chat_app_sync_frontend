class AppException implements Exception{
  final String _message;
  final String _prefix;

  AppException([this._message = '', this._prefix='']);

  @override
  String toString() {
    return '$_prefix$_message';
  }
}

  class ResourceNotFound extends AppException{
    ResourceNotFound([message]) : super(message, 'Resource not found exception:');
  }
  class InvalidPrameter extends AppException {
  InvalidPrameter([message]) : super(message, 'Bad request exception: ');
}
class UnauthoriseException extends AppException {
  UnauthoriseException([message]) : super(message, 'Unauthorised: ');
}

class FetchDataException extends AppException {
  FetchDataException([message])
      : super(message,
            'Error occured while Communication with Server with StatusCode: ');
}
class ForbiddenExeption extends AppException {
  ForbiddenExeption([message]) : super(message, 'Forbidden exception: ');
}


