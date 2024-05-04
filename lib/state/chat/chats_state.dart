part of 'chats_bloc.dart';

sealed class ChatsState {
  final List<UserModel> connections;

  ChatsState({required this.connections});
}

final class ChatsInitial extends ChatsState {
  ChatsInitial({required super.connections});
}

final class ChatsUpdated extends ChatsState {
  ChatsUpdated({required super.connections});
}
