import 'package:flutter/material.dart';
import 'package:qubit/presentation/auth/widgets/note_and_button_widget.dart';
import 'package:qubit/presentation/auth/login/widgets/google_and_login_button.dart';
import 'package:qubit/presentation/auth/widgets/custom_text_field.dart';
import 'package:qubit/constants/validation_constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  late AnimationController _entryAnimationController;
  late Animation<Offset> _emailSlideAnimation;
  late Animation<Offset> _passwordSlideAnimation;
  late Animation<Offset> _noteSlideAnimation;

  @override
  void initState() {
    super.initState();

    _entryAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _emailSlideAnimation = Tween<Offset>(
      begin: const Offset(0, -10),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _entryAnimationController,
        curve: const Interval(0, 0.5),
      ),
    );

    _passwordSlideAnimation = Tween<Offset>(
      begin: const Offset(0, -10),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _entryAnimationController,
        curve: const Interval(0.1, 0.6),
      ),
    );

    _noteSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 10),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _entryAnimationController,
        curve: const Interval(0.3, 1.0),
      ),
    );

    _entryAnimationController.forward();
  }

  @override
  void dispose() async {
    super.dispose();
    _entryAnimationController.reverse();
    await Future.delayed(const Duration(seconds: 1));
    _entryAnimationController.dispose();
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
                    position: _passwordSlideAnimation,
                    child: CustomTextFromField(
                      hintText: 'Password',
                      controller: _password,
                      obscureText: true,
                      validator: passwordValidation,
                    ),
                  ),
                  const SizedBox(height: 20),
                  GoogleAndLoginButton(
                    formKey: _formKey,
                    email: _email,
                    password: _password,
                  ),
                  const SizedBox(height: 20),
                  SlideTransition(
                    position: _noteSlideAnimation,
                    child: const CustomNoteWithTextButton(
                      route: '/signup',
                      note: 'Don\'t have an account',
                      button: 'create account',
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
}
