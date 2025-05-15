import 'package:flutter/cupertino.dart';

abstract class BaseApiService {

   Future<T> get<T>(
    String url, {
    required Map<String, String> headers,
    required T Function(Map<String, dynamic>) fromJson,
  });

   Future<List<T>> getList<T>(
    String url, {
    required Map<String, String> headers,
    required T Function(Map<String, dynamic>) fromJson,
  });

  Future<T> post<T>(
    String url, {
    required Map<String, String> headers,
    required Map<String, dynamic> body,
    required T Function(Map<String, dynamic>) fromJson,
  });

   Future<T> postWithoutToJson<T>(
       String url, {
         required Map<String, String> headers,
         required T Function(Map<String, dynamic>) fromJson,
       });

  Future<T> put<T>(
    String url, {
    required Map<String, String> headers,
    required Map<String, dynamic> body,
    required T Function(Map<String, dynamic>) fromJson,
  });

  Future<void> delete(
    String url, {
    required Map<String, String> headers,
  });
}
