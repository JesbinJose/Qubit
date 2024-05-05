import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:qubit/presentation/splash/splash.dart';
import 'package:qubit/state/chat/chats_bloc.dart';
import 'package:qubit/state/message/message_cubit.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ChatsBloc()),
        BlocProvider(create: (context) => MessageCubit()),
      ],
      child: GetMaterialApp(
        title: 'Qubit',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: const SplashScreen(),
      ),
    );
  }
}
