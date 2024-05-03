import 'package:flutter/material.dart';
import 'package:qubit/presentation/auth/sign_up/sign_up.dart';
import 'package:qubit/presentation/auth/widgets/note_and_button_widget.dart';
import 'package:qubit/presentation/auth/login/widgets/google_and_login_button.dart';
import 'package:qubit/presentation/auth/widgets/custom_text_field.dart';
import 'package:qubit/constants/validation_constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
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
                    hintText: 'Password',
                    controller: _password,
                    obscureText: true,
                    validator: passwordValidation,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GoogleAndLoginButton(
                    formKey: _formKey,
                    email: _email,
                    password: _password,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const CustomNoteWithTextButton(
                    widget: SignUpScreen(),
                    note: 'Don\'t have an account',
                    button: 'create account',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
