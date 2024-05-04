import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qubit/presentation/chat/widgets/chat_screen.dart';
import 'package:qubit/responsive.dart';
import 'package:qubit/state/chat/chats_bloc.dart';

import 'widgets/connected_users_part.dart';

class AllUsersScreen extends StatefulWidget {
  const AllUsersScreen({super.key});

  @override
  State<AllUsersScreen> createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends State<AllUsersScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatsBloc(),
      child: Scaffold(
        appBar: Responsive.isMobile(context)
            ? AppBar(
                title: const Text('Data'),
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
      ),
    );
  }
}
