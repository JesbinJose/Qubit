part of 'chats_bloc.dart';

sealed class ChatsEvent {}

class SearchChatEvent extends ChatsEvent{
  final String query;
  SearchChatEvent({required this.query});
}