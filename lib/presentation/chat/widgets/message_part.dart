import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qubit/presentation/chat/widgets/date_widget.dart';
import 'package:qubit/presentation/chat/widgets/message.dart';
import 'package:qubit/utils/cache.dart';

import '../../../state/message/message_cubit.dart';

class MessagesPart extends StatelessWidget {
  const MessagesPart({
    super.key,
    required this.scrollController,
  });
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageCubit, MessageState>(
      builder: (context, state) {
        if (state.username?.isNotEmpty != true) {
          return const Center(
            child: Text('Select a person and start chatting'),
          );
        }
        return Transform.rotate(
          angle: pi,
          child: SingleChildScrollView(
            child: ListView.separated(
              controller: scrollController,
              shrinkWrap: true,
              reverse: true,
              itemCount: state.messages.length,
              separatorBuilder: (context, index) => const SizedBox(
                height: 5,
              ),
              itemBuilder: (context, index) {
                final message = state.messages[index];
                bool isuser = message.id == currentUser!.userId;
                return Transform.rotate(
                  angle: pi,
                  child: Column(
                    children: [
                      DateWidget(
                        message: message,
                        time: index == 0
                            ? null
                            : state.messages[index - 1].time,
                        index: index,
                      ),
                      MessageWidget(
                        isuser: isuser,
                        message: state.messages[index].content,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
