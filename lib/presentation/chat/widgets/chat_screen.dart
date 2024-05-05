import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qubit/presentation/chat/widgets/message_part.dart';
import 'package:qubit/presentation/chat/widgets/message_text_field_bar.dart';
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

  final ScrollController _scrollController =
      ScrollController(initialScrollOffset: -10000);

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
          MessageTextFieldBar(message: _message),
        ],
      ),
    );
  }
}
