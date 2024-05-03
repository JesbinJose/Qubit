import 'package:flutter/material.dart';
import 'package:qubit/presentation/auth/login/widgets/create_account_button.dart';
import 'package:qubit/presentation/auth/login/widgets/google_and_login_button.dart';
import 'package:qubit/presentation/auth/widgets/custom_text_field.dart';
import 'package:qubit/presentation/constants/validation_constants.dart';

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
                    validator: _emailValidation,
                  ),
                  CustomTextFromField(
                    hintText: 'Password',
                    controller: _password,
                    obscureText: true,
                    validator: _passwordValidation,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GoogleAndLoginButton(
                    formKey: _formKey,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const CreateAccountButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? _passwordValidation(String? p0) {
    if (p0 == null || p0.isEmpty) return 'Email is mandatory';
    if (p0.length < 6) {
      return "Password must be at least 6 characters long";
    }
    return null;
  }

  String? _emailValidation(String? p0) {
    if (p0 == null || p0.isEmpty) return 'Email is mandatory';
    if (!RegExp(emailValidationRegEx).hasMatch(p0)) {
      return 'Please enter a valid email';
    }
    return null;
  }
}
