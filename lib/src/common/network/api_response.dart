import 'dart:convert';

import 'package:dio/dio.dart';

enum Status {
  success,
  cancel,
  timeOut,
  unKnown,
  resourceNotFound,
  invalidParam,
  forbidden,
  serverError
}

extension StatusExt on Status {
  String get message {
    switch (this) {
      case Status.success:
        return 'Thành công';
      case Status.cancel:
        return 'Cancle';
      case Status.timeOut:
        return 'Request take too much time, please try it again';
      case Status.resourceNotFound:
        return 'Resource not found, plese try again';
      case Status.invalidParam:
        return 'Invalid param, please try it again';
      case Status.forbidden:
        return 'Forbidden';
      case Status.serverError:
        return "Server error, please try it again";
      default:
        return 'Undefine error, please try it again';
    }
  }
}

class ResponseData<T> {
  T? data;
  Status? status;
  String? message;

  bool? isSuccess() {
    return status == Status.success;
  }

  ResponseData.success(this.data, {dynamic response}) {
    status = Status.success;

    if (response is Map<String, dynamic>) {
      final statusCode = response['code'];

      if (statusCode != null) {
        status = _mapCodeToState(statusCode);
        message = response['message'] ?? response['description'];
      }
    }

    message = message?.isEmpty == true ? status?.message : message;
  }
  ResponseData.failed(dynamic error) {
    if (error is DioError || error is DioErrorType) {
      status = _mapErrorToState(error);
      try {
        final json = jsonDecode(error?.respons.toString() ?? '');
        if (json == null) {
          message = status?.message;
        } else {
          message = json['message'].toString();
          message = message?.isEmpty == true
              ? json['description'].toString()
              : message;
        }
      } catch (e) {
        message = status?.message;
      }
    }
  }
  Status _mapCodeToState(int statusCode) {
    switch (statusCode) {
      case 200:
        return Status.success;
      case 400:
        return Status.invalidParam;
      case 404:
        return Status.resourceNotFound;
      case 500:
        return Status.serverError;
      default:
        return Status.unKnown;
    }
  }

  Status _mapErrorToState(dynamic error) {
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.cancel:
          return Status.cancel;
        case DioErrorType.connectTimeout:
        case DioErrorType.receiveTimeout:
        case DioErrorType.sendTimeout:
          return Status.timeOut;
        default:
          return Status.unKnown;
      }
    }
    return Status.unKnown;
  }
}
