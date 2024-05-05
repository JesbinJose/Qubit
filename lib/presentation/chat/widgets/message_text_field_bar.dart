import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qubit/state/message/message_cubit.dart';

class MessageTextFieldBar extends StatelessWidget {
  const MessageTextFieldBar({
    super.key,
    required TextEditingController message,
  }) : _message = message;

  final TextEditingController _message;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageCubit, MessageState>(
      builder: (context, state) {
        if (state.username?.isNotEmpty != true) return const SizedBox();
        return Container(
          width: double.infinity,
          height: 60,
          color: Colors.black12,
          child: TextField(
            controller: _message,
            onSubmitted: (_) {
              context
                  .read<MessageCubit>()
                  .sendMessage(_message.text, state.email!);
              _message.clear();
            },
            textInputAction: TextInputAction.send,
            autofocus: true,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: 'Type a message...',
              suffixIcon: IconButton(
                icon: const Icon(Icons.send),
                tooltip: 'Send',
                onPressed: () {
                  context
                      .read<MessageCubit>()
                      .sendMessage(_message.text, state.email!);
                  _message.clear();
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
