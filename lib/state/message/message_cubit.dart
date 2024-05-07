import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qubit/utils/cache.dart';
import 'package:qubit/features/user/users_data.dart';
import 'package:qubit/model/message.dart';
import 'package:qubit/model/user.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  MessageCubit() : super(MessageInitial(messages: [], username: ''));

  WebSocketChannel? _channel;

  void changeSelectedUser(UserModel toUser) async {
    final List<Message>? messages =
        await UserData().getPreviousMessages(toUser.userId);
    if (messages == null) return;
    connect(currentUser!.userId.toString(), toUser.userId.toString());
    emit(MessageUpdated(
      messages: messages,
      username: toUser.username,
      email: toUser.email,
    ));
  }

  void connect(String senderId, String receiverId) {
    //checking any error
    dynamic fn(Object o, StackTrace s) {
      debugPrint(o.toString());
    }

    try {
      final url = Uri.parse(
          'wss://backendrealchat.molla.cloud/chat/$senderId/?$receiverId');
      _channel = WebSocketChannel.connect(url);
      _channel!.stream.listen((message) {
        final newMessage = Message.fromJson(jsonDecode(message)['messages']);
        if(state.messages.last.messageid!=newMessage.messageid) {
          emit(
          MessageUpdated(
            username: state.username,
            email: state.email,
            messages: [...state.messages, newMessage],
          ),
        );
        }
      }).onError(fn);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  void sendMessage(String message, String tomail) async {
    if (_channel == null) return;
    _channel!.sink.add(jsonEncode({
      'message': message,
      'senderUsername': tomail,
      'recieverUsername': currentUser!.email,
    }));
  }

  void clear() {
    _channel?.sink.close();
    currentUser = null;
    apiKey = '';
    connections = [];
    emit(
      MessageUpdated(
        messages: [],
        username: '',
        email: '',
      ),
    );
  }
}
