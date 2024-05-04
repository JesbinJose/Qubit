import 'package:dio/dio.dart';
import 'package:get/route_manager.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:qubit/cache.dart';
import 'package:qubit/constants/endpoints.dart';
import 'package:qubit/model/user.dart';
import 'package:qubit/presentation/auth/login/login.dart';

class UserData {
  Future<List<UserModel>?> getCurrentUserData() async {
    if (apiKey.isEmpty) {
      Get.off(const LoginScreen());
      return null;
    } else {
      final Dio dio = Dio();
      final userId = JwtDecoder.decode(apiKey)['user_id'];
      final Response resp = await dio.get(
        '$baseUrl$getAllConnectionEndpoint$userId/',
        options: Options(
          headers: {'Authorization': 'Bearer $apiKey'},
        ),
      );
      currentUser = UserModel.fromJson(resp.data);
      final connectionList = resp.data['connections'] as List;
      return List.generate(
        connectionList.length,
        (index) => UserModel.fromJson(
          connectionList[index],
        ),
      );
    }
  }

  Future<List<UserModel>?> searchUsers(String query) async {
    if (query.isEmpty) return null;
    if (apiKey.isEmpty) {
      Get.off(const LoginScreen());
      return null;
    } else {
      final Dio dio = Dio();
      final Response resp = await dio.get(
        '$baseUrl$searchUserEndpoint?search=$query',
        options: Options(
          headers: {'Authorization': 'Bearer $apiKey'},
        ),
      );
      final connectionList = resp.data as List;
      return List.generate(
        connectionList.length,
        (index) => UserModel.fromJson(
          connectionList[index],
        ),
      );
    }
  }
}
