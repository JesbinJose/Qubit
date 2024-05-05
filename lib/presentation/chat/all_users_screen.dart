import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qubit/presentation/chat/widgets/chat_screen.dart';
import 'package:qubit/responsive.dart';
import 'package:qubit/state/message/message_cubit.dart';

import 'widgets/connected_users_part.dart';

class AllUsersScreen extends StatelessWidget {
  const AllUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Responsive.isMobile(context)
          ? AppBar(
              title: BlocBuilder<MessageCubit, MessageState>(
                builder: (context, state) {
                  return Text(state.username ?? '');
                },
              ),
            )
          : null,
      drawer: const ConnectedUsersPart(),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Visibility(
            visible: !Responsive.isMobile(context),
            child: const ConnectedUsersPart(),
          ),
          const ChatScreen(),
        ],
      ),
    );
  }
}
