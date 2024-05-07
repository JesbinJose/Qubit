import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:qubit/utils/cache.dart';
import 'package:qubit/features/auth/email_auth.dart';
import 'package:qubit/features/auth/google_auth.dart';
import 'package:qubit/features/local_data/save_credentials.dart';
import 'package:qubit/features/user/users_data.dart';
import 'package:qubit/presentation/auth/widgets/custom_auth_button.dart';
import 'package:qubit/presentation/chat/all_users_screen.dart';
import 'package:qubit/presentation/widgets/snakbar.dart';
import 'package:svg_flutter/svg.dart';

class GoogleAndLoginButton extends StatefulWidget {
  const GoogleAndLoginButton({
    required this.formKey,
    required this.email,
    required this.password,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController email;
  final TextEditingController password;

  @override
  State<GoogleAndLoginButton> createState() => _GoogleAndLoginButtonState();
}

class _GoogleAndLoginButtonState extends State<GoogleAndLoginButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _loginButtonAnimation;
  late Animation<Offset> _googleButtonAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _loginButtonAnimation = Tween<Offset>(
      begin: const Offset(-10, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _googleButtonAnimation = Tween<Offset>(
      begin: const Offset(10, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SlideTransition(
          position: _loginButtonAnimation,
          child: CustomAuthButton(
            onTap: _loginWithEmailAndPassword,
            widget: const Text("Login"),
          ),
        ),
        const SizedBox(height: 10,),
        SlideTransition(
          position: _googleButtonAnimation,
          child: CustomAuthButton(
            onTap: _loginWithGoogle,
            widget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 45,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SvgPicture.asset('assets/google.svg'),
                  ),
                ),
                const Center(
                  child: SizedBox(
                    width: 150,
                    child: Text(
                      'Sign In With Google',
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _loginWithEmailAndPassword() async {
    if (widget.formKey.currentState?.validate() != true) return;
    final key = await EmailAuth().signinWithEmailAndPassword(
      email: widget.email.text,
      password: widget.password.text,
    );
    if (key != null) {
      LocalDatabase().saveData(key);
      apiKey = key;
      connections = await UserData().getCurrentUserData() ?? [];
      Get.off(
        const AllUsersScreen(),
      );
      showCustomSnakbar('Login Successful', '');
    } else {
      showCustomSnakbar(
        'Login Faild',
        'Please verify you email and password is correct',
      );
    }
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
      connections = await UserData().getCurrentUserData() ?? [];
      Get.off(
        const AllUsersScreen(),
        transition: Transition.fadeIn,
        duration: const Duration(
          milliseconds: 500,
        ),
      );
    }
    if (key != null) {
      showCustomSnakbar('Login Successful', '');
    } else {
      showCustomSnakbar(
        'Login faild',
        'Please Verify your google account',
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
