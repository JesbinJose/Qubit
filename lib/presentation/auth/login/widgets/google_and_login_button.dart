import 'package:flutter/material.dart';
import 'package:qubit/presentation/auth/widgets/custom_auth_button.dart';
import 'package:svg_flutter/svg.dart';

class GoogleAndLoginButton extends StatelessWidget {
  const GoogleAndLoginButton({
    super.key,
    required this.formKey,
  });
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomAuthButton(
          onTap: () {
          },
          widget: const Text("Login"),
        ),
        const SizedBox(
          width: 20,
        ),
        CustomAuthButton(
          onTap: () {},
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
}
