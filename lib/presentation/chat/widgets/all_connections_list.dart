import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qubit/state/chat/chats_bloc.dart';
import 'package:qubit/state/message/message_cubit.dart';

class AllConnectionsList extends StatelessWidget {
  const AllConnectionsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatsBloc, ChatsState>(
      builder: (context, state) {
        if (state.connections.isEmpty) {
          return const SizedBox();
        }
        return ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final String username = state.connections[index].username;
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                onTap: () {
                  context.read<MessageCubit>().changeSelectedUser(
                        state.connections[index],
                      );
                  Scaffold.of(context).closeDrawer();
                },
                title: Text(
                  username,
                ),
                leading: CircleAvatar(
                  backgroundColor: Colors.black12,
                  child: Text(
                    username[0].toUpperCase(),
                  ),
                ),
              ),
            );
          },
          itemCount: state.connections.length,
        );
      },
    );
  }
}
