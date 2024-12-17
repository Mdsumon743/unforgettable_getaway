import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../model/model.dart';

class NetworkCaller {
  final int timeoutDuration = 10;

  Uri _parseUrl(String url) {
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'http://$url';
    }
    return Uri.parse(url);
  }

  Future<ResponseData> _makeRequest(
    String method,
    String url, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    String? token,
  }) async {
    final parsedUrl = _parseUrl(url);
    headers ??= {};
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    headers['Content-Type'] = 'application/json';

    log('Request Method: $method');
    log('Request URL: $parsedUrl');
    if (body != null) log('Request Body: ${jsonEncode(body)}');

    try {
      late http.Response response;

      switch (method) {
        case 'GET':
          response = await http
              .get(parsedUrl, headers: headers)
              .timeout(Duration(seconds: timeoutDuration));
          break;
        case 'POST':
          response = await http
              .post(parsedUrl, headers: headers, body: jsonEncode(body))
              .timeout(Duration(seconds: timeoutDuration));
          break;
        case 'PUT':
          response = await http
              .put(parsedUrl, headers: headers, body: jsonEncode(body))
              .timeout(Duration(seconds: timeoutDuration));
          break;
        case 'DELETE':
          response = await http
              .delete(parsedUrl, headers: headers, body: jsonEncode(body))
              .timeout(Duration(seconds: timeoutDuration));
          break;
        case 'PATCH':
          response = await http
              .patch(parsedUrl, headers: headers, body: jsonEncode(body))
              .timeout(Duration(seconds: timeoutDuration));
          break;
        default:
          throw UnsupportedError('HTTP method $method not supported');
      }

      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<ResponseData> getRequest(String url, {String? token}) {
    return _makeRequest('GET', url, token: token);
  }

  Future<ResponseData> postRequest(String url,
      {Map<String, dynamic>? body, String? token}) {
    return _makeRequest('POST', url, body: body, token: token);
  }

  Future<ResponseData> putRequest(String url,
      {Map<String, dynamic>? body, String? token}) {
    return _makeRequest('PUT', url, body: body, token: token);
  }

  Future<ResponseData> deleteRequest(String url,
      {Map<String, dynamic>? body, String? token}) {
    return _makeRequest('DELETE', url, body: body, token: token);
  }

  Future<ResponseData> patchRequest(String url,
      {Map<String, dynamic>? body, String? token}) {
    return _makeRequest('PATCH', url, body: body, token: token);
  }

  ResponseData _handleResponse(http.Response response) {
    log('Response Status: ${response.statusCode}');
    log('Response Body: ${response.body}');

    try {
      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return ResponseData(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodedResponse['data'] ?? decodedResponse,
          errorMessage: '',
        );
      } else {
        return ResponseData(
          isSuccess: false,
          statusCode: response.statusCode,
          responseData: decodedResponse,
          errorMessage: decodedResponse['message'] ?? 'An error occurred',
        );
      }
    } catch (e) {
      return ResponseData(
        isSuccess: false,
        statusCode: response.statusCode,
        responseData: '',
        errorMessage: 'Failed to parse response: $e',
      );
    }
  }

  ResponseData _handleError(dynamic error) {
    log('Request Error: $error');

    if (error is TimeoutException) {
      return ResponseData(
        isSuccess: false,
        statusCode: 408,
        responseData: '',
        errorMessage: 'Request timeout. Please try again later.',
      );
    } else if (error is http.ClientException) {
      return ResponseData(
        isSuccess: false,
        statusCode: 500,
        responseData: '',
        errorMessage: 'Network error. Please check your connection.',
      );
    } else {
      return ResponseData(
        isSuccess: false,
        statusCode: 500,
        responseData: '',
        errorMessage: 'Unexpected error occurred: $error',
      );
    }
  }
}
