// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../exceptions/net_work_excptions.dart';
import 'base_api_services.dart';

class HttpApiService implements BaseApiService {
  @override
  Future<T> get<T>(
    String url, {
    required Map<String, String> headers,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      throw Exception('GET failed: ${response.statusCode}  ${response.body}');
    }
  }

  @override
  Future<List<T>> getList<T>(
    String url, {
    required Map<String, String> headers,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final data = jsonDecode(response.body) as List;
      return data.map((e) => fromJson(e)).toList();
    } else {
      throw Exception(
          'GET List failed: ${response.statusCode}  ${response.body}');
    }
  }

  @override
  Future<T> post<T>(
    String url, {
    required Map<String, String> headers,
    required Map<String, dynamic> body,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    final response = await http
        .post(
          Uri.parse(url),
          headers: headers,
          body: jsonEncode(body),
        )
        .timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      return fromJson(jsonDecode(response.body));
    } else {
      throw Exception('POST failed: ${response.statusCode}  ${response.body}');
    }
  }

  @override
  Future<T> put<T>(
    String url, {
    required Map<String, String> headers,
    required Map<String, dynamic> body,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    final response = await http
        .put(
          Uri.parse(url),
          headers: headers,
          body: jsonEncode(body),
        )
        .timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      return fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
          'PUT failed: ${response.statusCode} ${response.body.toString()}');
    }
  }

  @override
  Future<void> delete(
    String url, {
    required Map<String, String> headers,
  }) async {
    final response = await http
        .delete(Uri.parse(url), headers: headers)
        .timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      ExceptionHandler.handleApiResponse(response);
    } else {
      throw Exception(
          'DELETE failed: ${response.statusCode}  ${response.body}');
    }
  }

  @override
  Future<T> postWithoutToJson<T>(
      String url,{
        required Map<String, String> headers,
        required T Function(Map<String, dynamic>) fromJson,
      }) async {
    final response = await http.post(Uri.parse(url), headers: headers).timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      final decodedBody = jsonDecode(response.body);
      if (decodedBody is Map<String, dynamic>) {
        return fromJson(decodedBody);
      } else {
        throw FormatException('Expected JSON object but got: ${response.body}');
      }
    } else {
      throw Exception('POST failed: ${response.statusCode} ${response.body}');
    }
  }

  @override
  Future<T?> postImage<T>(
      String url, {
        required Map<String, String> headers,
        required File imageFile,
        required String imageFieldName,
        T Function(Map<String, dynamic>)? fromJson,
      }) async {
    final request = http.MultipartRequest('POST', Uri.parse(url))
      ..headers.addAll(headers)
      ..files.add(await http.MultipartFile.fromPath(imageFieldName, imageFile.path));
     final streamedResponse = await request.send().timeout(const Duration(seconds: 15));
     final response = await http.Response.fromStream(streamedResponse);
     if (response.statusCode == 200) {
      if (fromJson != null) {
        final decoded = jsonDecode(response.body);
        if (decoded is Map<String, dynamic>) {
          return fromJson(decoded);
        } else {
          throw FormatException('Expected JSON object but got: ${response.body}');
        }
      } else {
        return null;
      }
    } else {
      throw Exception('Image POST failed: ${response.statusCode} ${response.body}');
    }
  }

  @override
  Future<T> postGetter<T>(
      String url, {
        required Map<String, String> headers,
        required T Function(Map<String, dynamic>) fromJson,
      }) async {
    final response = await http.post(Uri.parse(url), headers: headers);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      throw Exception('PostGetter failed: ${response.statusCode} ${response.body}');
    }
  }


}
