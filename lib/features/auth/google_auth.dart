import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:qubit/constants/endpoints.dart';
import 'package:qubit/keys.dart';
import 'package:qubit/presentation/widgets/snakbar.dart';

class AuthUsingGoogle {
  Future<(String?, String)> loginWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: googleAuthWebClientId,
    );
    final googleUser = await googleSignIn.signIn();
    print('object');
    final googleAuth = await googleUser!.authentication;
    print('object');
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
      showCustomSnakbar('Somthing Went wrong', e.toString());
      return null;
    }
  }
}
