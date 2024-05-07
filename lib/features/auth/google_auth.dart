import 'package:dio/dio.dart';
import 'package:get/route_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:qubit/utils/cache.dart';
import 'package:qubit/constants/endpoints.dart';
import 'package:qubit/features/local_data/save_credentials.dart';
import 'package:qubit/keys.dart';

class AuthUsingGoogle {
  Future<(String?, String)> loginWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: googleAuthWebClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    return (googleAuth.accessToken, googleUser.email);
  }

  Future<String?> getApikeyFormGoogleLogin(String token, String email) async {
    try {
      final Response resp = await Dio().post(
        '$baseUrl$googleLoginEndpoint',
        data: {
          "email": email,
          "access_token": token,
        },
      );
      return resp.data['token']['access'];
    } catch (e) {
      return null;
    }
  }

  Future<bool> logout() async {
    try {
      LocalDatabase().remove();
      apiKey = '';
      Get.offNamed('/login');
      return true;
    } catch (e) {
      return false;
    }
  }
}
