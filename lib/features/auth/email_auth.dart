import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/route_manager.dart';
import 'package:qubit/utils/cache.dart';
import 'package:qubit/constants/endpoints.dart';
import 'package:qubit/features/local_data/save_credentials.dart';
import 'package:qubit/presentation/auth/login/login.dart';

class EmailAuth {
  Future<String?> signinWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final Response resp = await Dio().post(
        '$baseUrl$signInEndpoint',
        data: {
          "email": email,
          "password": password,
        },
      );
      return resp.data['access'];
    } catch (e) {
      return null;
    }
  }

  Future<bool> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String username,
    required String confirmPassword,
  }) async {
    final dio = Dio();

    try {
      final response = await dio.post(
        '$baseUrl$signUpEndpoint',
        data: {
          "email": email,
          "username": username,
          "password": password,
          "password2": confirmPassword,
          "is_google": false,
        },
      );

      if (response.statusCode == 200) {
        debugPrint('Signup successful: ${response.data}');
        return true;
      } else {
        debugPrint('Signup failed with code: ${response.statusCode}');
        debugPrint('Server response: ${response.data}');
        return false;
      }
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          debugPrint('Network timeout error during signup');
          return false;
        default:
          debugPrint('Unexpected DioError: $e');
          return false;
      }
    } catch (e) {
      debugPrint('General error during signup: $e');
      return false;
    }
  }

  Future<bool> logout() async {
    try {
      LocalDatabase().remove();
      apiKey = '';
      Get.off(const LoginScreen());
      return true;
    } catch (e) {
      return false;
    }
  }
}
