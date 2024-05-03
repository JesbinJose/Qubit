import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qubit/features/auth/email_auth.dart';
import 'package:qubit/presentation/auth/login/login.dart';
import 'package:qubit/presentation/auth/widgets/custom_auth_button.dart';
import 'package:qubit/presentation/auth/widgets/custom_text_field.dart';
import 'package:qubit/presentation/auth/widgets/note_and_button_widget.dart';
import 'package:qubit/constants/validation_constants.dart';
import 'package:qubit/presentation/widgets/snakbar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(
            minWidth: 250,
            maxWidth: 500,
          ),
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextFromField(
                    hintText: 'Email',
                    controller: _email,
                    validator: emailValidation,
                  ),
                  CustomTextFromField(
                    hintText: 'User Name',
                    controller: _userName,
                    validator: userNameValidation,
                  ),
                  CustomTextFromField(
                    hintText: 'Password',
                    controller: _password,
                    obscureText: true,
                    validator: passwordValidation,
                  ),
                  CustomTextFromField(
                    hintText: 'Confirm Password',
                    controller: _confirmPassword,
                    obscureText: true,
                    validator: (p0) => confirmPasswordValidation(
                      p0,
                      _password.text,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      CustomAuthButton(
                        onTap: _createAccount,
                        widget: const Text('Create account'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const CustomNoteWithTextButton(
                    widget: LoginScreen(),
                    note: 'Already have an account',
                    button: 'Sign in',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _createAccount() async {
    if (_formKey.currentState?.validate() != true) return;
    final bool isAccountCreated = await EmailAuth().signUpWithEmailAndPassword(
      email: _email.text,
      password: _password.text,
      username: _userName.text,
      confirmPassword: _confirmPassword.text,
    );
    if (isAccountCreated == true) {
      showCustomSnakbar(
        "Verifiation email has sent",
        "Please check mails at ${_email.text}. and Verfy it so you can login to you account .Please check spam also it may be there",
      );
      Get.off(const LoginScreen());
    }
  }
}
