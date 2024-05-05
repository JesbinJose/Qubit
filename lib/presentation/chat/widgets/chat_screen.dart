import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qubit/presentation/chat/widgets/message_part.dart';
import 'package:qubit/responsive.dart';
import 'package:qubit/state/message/message_cubit.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _message = TextEditingController();

  final ScrollController _scrollController = ScrollController(initialScrollOffset: -10000);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Visibility(
            visible: !Responsive.isMobile(context),
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(),
                ),
              ),
              child: Center(
                child: BlocBuilder<MessageCubit, MessageState>(
                  builder: (context, state) {
                    return Text(state.username ?? '');
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: MessagesPart(
              scrollController: _scrollController,
            ),
          ),
          Container(
            width: double.infinity,
            height: 60,
            color: Colors.black12,
            child: TextField(
              controller: _message,
              onSubmitted: (_) =>
                  context.read<MessageCubit>().sendMessage(_message.text),
              textInputAction: TextInputAction.send,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                suffixIcon: IconButton(
                    icon: const Icon(Icons.send),
                    tooltip: 'Send',
                    onPressed: () {
                      context.read<MessageCubit>().sendMessage(_message.text);
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
