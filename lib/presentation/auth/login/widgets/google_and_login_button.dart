import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qubit/cache.dart';
import 'package:qubit/features/auth/email_auth.dart';
import 'package:qubit/features/auth/google_auth.dart';
import 'package:qubit/features/local_data/save_credentials.dart';
import 'package:qubit/presentation/auth/widgets/custom_auth_button.dart';
import 'package:qubit/presentation/chat/all_user/all_users_screen.dart';
import 'package:qubit/presentation/widgets/snakbar.dart';
import 'package:svg_flutter/svg.dart';

class GoogleAndLoginButton extends StatelessWidget {
  const GoogleAndLoginButton({
    super.key,
    required this.formKey,
    required this.email,
    required this.password,
  });
  final GlobalKey<FormState> formKey;
  final TextEditingController email;
  final TextEditingController password;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomAuthButton(
          onTap: _loginWithEmailAndPassword,
          widget: const Text("Login"),
        ),
        const SizedBox(
          width: 20,
        ),
        CustomAuthButton(
          onTap: _loginWithGoogle,
          widget: Row(
            children: [
              SizedBox(
                width: 50,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SvgPicture.asset('assets/google.svg'),
                ),
              ),
              const Center(child: Text('Sign In With Google')),
            ],
          ),
        ),
      ],
    );
  }

  _loginWithEmailAndPassword() async {
    if (formKey.currentState?.validate() != true) return;
    final key = await EmailAuth().signinWithEmailAndPassword(
      email: email.text,
      password: password.text,
    );
    if (key != null) {
      LocalDatabase().saveData(key);
      apiKey = key;
      Get.off(const AllUsersScreen());
    } else {
      debugPrint('Something went wrong');
    }
    showCustomSnakbar('Login Successful', '');
  }

  _loginWithGoogle() async {
    final data = await AuthUsingGoogle().loginWithGoogle();
    if (data.$1 == null) return;
    final key = await AuthUsingGoogle().getApikeyFormGoogleLogin(
      data.$1!,
      data.$2,
    );
    if (key != null) {
      LocalDatabase().saveData(key);
      apiKey = key;
      Get.off(const AllUsersScreen());
    }
    showCustomSnakbar('Login Successful', '');
  }
}
