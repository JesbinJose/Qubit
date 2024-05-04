import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qubit/state/chat/chats_bloc.dart';

void debouncedSearch(String value, BuildContext context) {
  Timer? timer;
  void performSearch() {
    context.read<ChatsBloc>().add(SearchChatEvent(query: value));
  }

  void cancelTimer() => timer?.cancel();

  timer = Timer(const Duration(seconds: 1), performSearch);
  cancelTimer;
}

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Search',
        ),
        onChanged: (value) {
          debouncedSearch(value, context);
        },
      ),
    );
  }
}
