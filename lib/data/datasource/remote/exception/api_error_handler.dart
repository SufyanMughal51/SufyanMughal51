import 'package:dio/dio.dart';
import 'package:flutter_restaurant/data/model/response/base/error_response.dart';

class ApiErrorHandler {
  static dynamic getMessage(error) {
    dynamic errorDescription = "";
    if (error is Exception) {
      try {
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.cancel:
              errorDescription = "Request to API server was cancelled";
              break;
            case DioErrorType.connectionTimeout:
              errorDescription = "Connection timeout with API server";
              break;
            case DioErrorType.connectionError:
              errorDescription =
                  "Connection to API server failed due to internet connection";
              break;
            case DioErrorType.badCertificate:
              errorDescription =
                  "Connection to API server failed due to an incorrect certificate as configured by ValidateCertificate";
              break;
            case DioErrorType.unknown:
              errorDescription =
                  "Connection to API server failed due to default error type, some other Error.if it is not null";
              break;
            case DioErrorType.receiveTimeout:
              errorDescription =
                  "Receive timeout in connection with API server";
              break;
            case DioErrorType.badResponse:
              switch (error.response.statusCode) {
                case 404:
                  errorDescription = 'Not available';
                  break;
                case 500:
                case 503:
                  errorDescription = error.response.statusMessage;
                  break;
                default:
                  ErrorResponse errorResponse;
                  try {
                    errorResponse = ErrorResponse.fromJson(error.response.data);
                  } catch (e) {}
                  if (errorResponse != null &&
                      errorResponse.errors != null &&
                      errorResponse.errors.length > 0) {
                    print('error----------------== ${errorResponse.toJson()}');
                    errorDescription = errorResponse;
                  } else
                    errorDescription =
                        "Failed to load data - status code: ${error.response.statusCode}";
              }
              break;
            case DioErrorType.sendTimeout:
              errorDescription = "Send timeout with server";
              break;
          }
        } else {
          errorDescription = "Unexpected error occured";
        }
      } on FormatException catch (e) {
        errorDescription = e.toString();
      }
    } else {
      errorDescription = "is not a subtype of exception";
    }
    return errorDescription;
  }
}
