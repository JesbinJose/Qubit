import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qubit/cache.dart';

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
        if (state.messages.isEmpty) return const SizedBox();
        return Transform.rotate(
          angle: pi,
          child: SingleChildScrollView(
            child: ListView.separated(
              controller: scrollController,
              shrinkWrap: true,
              reverse: true,
              itemCount: state.messages.length,
              separatorBuilder: (context, index) => const SizedBox(height: 5,),
              itemBuilder: (context, index) {
                final message = state.messages[index];
                bool isuser = message.id == currentUser!.userId;
                return Transform.rotate(
                  angle: pi,
                  child: Align(
                    alignment: isuser?Alignment.centerRight:Alignment.centerLeft,
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 300),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: isuser ? Colors.black12 : Colors.white12,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(10),
                          topRight: const Radius.circular(10),
                          bottomLeft:
                              isuser ? const Radius.circular(10) : Radius.zero,
                          bottomRight:
                              isuser ? Radius.zero : const Radius.circular(10),
                        ),
                      ),
                      child: Text(
                        state.messages[index].content,
                      ),
                    ),
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
