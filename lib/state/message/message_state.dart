part of 'message_cubit.dart';

sealed class MessageState {
  final List<Message> messages;
  final String? username;
  final String? email;

  MessageState({
    required this.messages,
    required this.username,
    required this.email,
  });
}

final class MessageInitial extends MessageState {
  MessageInitial({
    required super.messages,
    super.username,
    super.email,
  });
}

final class MessageUpdated extends MessageState {
  MessageUpdated({
    required super.messages,
    required super.username,
    required super.email,
  });
}
