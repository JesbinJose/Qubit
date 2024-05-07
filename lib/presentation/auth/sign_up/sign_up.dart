import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qubit/features/auth/email_auth.dart';
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

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  late AnimationController _animationController;
  late Animation<Offset> _emailSlideAnimation;
  late Animation<Offset> _userNameSlideAnimation;
  late Animation<Offset> _passwordSlideAnimation;
  late Animation<Offset> _confirmPasswordSlideAnimation;
  late Animation<Offset> _buttonSlideAnimation;
  late Animation<Offset> _noteSlideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _emailSlideAnimation = Tween<Offset>(
      begin: const Offset(0, -10),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeInOut),
      ),
    );

    _userNameSlideAnimation = Tween<Offset>(
      begin: const Offset(0, -10),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.1, 0.5, curve: Curves.easeInOut),
      ),
    );

    _passwordSlideAnimation = Tween<Offset>(
      begin: const Offset(0, -10),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 0.6, curve: Curves.easeInOut),
      ),
    );

    _confirmPasswordSlideAnimation = Tween<Offset>(
      begin: const Offset(0, -10),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 0.7, curve: Curves.easeInOut),
      ),
    );

    _buttonSlideAnimation = Tween<Offset>(
      begin: const Offset(10, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.4, 0.8, curve: Curves.easeInOut),
      ),
    );

    _noteSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 10),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.6, 1.0, curve: Curves.easeInOut),
      ),
    );

    _animationController.forward();
  }

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
                  SlideTransition(
                    position: _emailSlideAnimation,
                    child: CustomTextFromField(
                      hintText: 'Email',
                      controller: _email,
                      validator: emailValidation,
                    ),
                  ),
                  SlideTransition(
                    position: _userNameSlideAnimation,
                    child: CustomTextFromField(
                      hintText: 'User Name',
                      controller: _userName,
                      validator: userNameValidation,
                    ),
                  ),
                  SlideTransition(
                    position: _passwordSlideAnimation,
                    child: CustomTextFromField(
                      hintText: 'Password',
                      controller: _password,
                      obscureText: true,
                      validator: passwordValidation,
                    ),
                  ),
                  SlideTransition(
                    position: _confirmPasswordSlideAnimation,
                    child: CustomTextFromField(
                      hintText: 'Confirm Password',
                      controller: _confirmPassword,
                      obscureText: true,
                      validator: (p0) => confirmPasswordValidation(
                        p0,
                        _password.text,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SlideTransition(
                    position: _buttonSlideAnimation,
                    child: CustomAuthButton(
                      onTap: _createAccount,
                      widget: const Text('Create account'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SlideTransition(
                    position: _noteSlideAnimation,
                    child: const CustomNoteWithTextButton(
                      route: '/login',
                      note: 'Already have an account',
                      button: 'Sign in',
                    ),
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
        "Verification email has been sent",
        "Please check your email at ${_email.text} and verify it to log in. Please also check your spam folder.",
      );
      Get.offNamed('/login');
    } else {
      showCustomSnakbar(
        "Somthing went wrong",
        "Maybe account already regestered try login",
      );
    }
  }

  @override
  void dispose() async {
    super.dispose();
    _animationController.reverse();
    await Future.delayed(const Duration(seconds: 1));
    _animationController.dispose();
  }
}
