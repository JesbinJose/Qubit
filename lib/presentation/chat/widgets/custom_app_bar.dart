import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qubit/state/message/message_cubit.dart';
import 'package:qubit/utils/cache.dart';
import 'package:qubit/features/auth/google_auth.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          child: Text(
            currentUser!.username[0].toUpperCase(),
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            context.read<MessageCubit>().clear();
            AuthUsingGoogle().logout();
          },
          icon: const Icon(Icons.logout),
        ),
      ],
    );
  }
}
