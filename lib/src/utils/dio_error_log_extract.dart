import 'package:dio/dio.dart';

String convertDioErrorToLogMessage(DioError error) {
  final targetUri = error.requestOptions.uri;
  final queryParameters = error.requestOptions.queryParameters;
  final sentData = error.requestOptions.data;
  final method = error.requestOptions.method;
  final sentHeaders = error.requestOptions.headers;

  final statusCode = error.response?.statusCode;
  final statusMessage = error.response?.statusMessage;
  final errorType = error.type;
  final responseData = error.response?.data;
  final responseHeaders = error.response?.headers;

  return """\n
error: $errorType
target: $targetUri
method: $method
request:
  query: $queryParameters
  body: $sentData
  headers: $sentHeaders
response:
  status: $statusCode $statusMessage
  body: $responseData
  headers: $responseHeaders
""";
}
