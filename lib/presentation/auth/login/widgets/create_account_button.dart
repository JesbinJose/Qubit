
import 'package:flutter/material.dart';

class CreateAccountButton extends StatelessWidget {
  const CreateAccountButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Don\'t have an account'),
        TextButton(
          onPressed: () {},
          child: const Text(
            'create account',
            style: TextStyle(),
          ),
        ),
      ],
    );
  }
}
