import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qubit/cache.dart';
import 'package:qubit/features/user/users_data.dart';
import 'package:qubit/model/user.dart';

part 'chats_event.dart';
part 'chats_state.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  ChatsBloc() : super(ChatsInitial(connections: connections)) {
    on<SearchChatEvent>((event, emit) async {
      emit(
        ChatsUpdated(
          connections: await UserData().searchUsers(event.query) ?? connections,
        ),
      );
    });
  }
}
