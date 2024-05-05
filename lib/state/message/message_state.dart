part of 'message_cubit.dart';

sealed class MessageState {
  final List<Message> messages;
  final String? username;

  MessageState({
    required this.messages,
    required this.username,
  });
}

final class MessageInitial extends MessageState {
  MessageInitial({
    required super.messages,
    super.username,
  });
}

final class MessageUpdated extends MessageState {
  MessageUpdated({
    required super.messages,
    required super.username,
  });
}
