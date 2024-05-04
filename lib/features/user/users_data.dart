import 'package:dio/dio.dart';
import 'package:get/route_manager.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:qubit/cache.dart';
import 'package:qubit/constants/endpoints.dart';
import 'package:qubit/model/user.dart';
import 'package:qubit/presentation/auth/login/login.dart';

class UserData {
  Future<UserModel?> getCurrentUserData() async {
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
      return UserModel.fromJson(resp.data);
    }
  }
}
