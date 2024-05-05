import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qubit/utils/cache.dart';
import 'package:qubit/features/local_data/save_credentials.dart';
import 'package:qubit/features/user/users_data.dart';
import 'package:qubit/presentation/auth/login/login.dart';
import 'package:qubit/presentation/chat/all_users_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _spashWork();
    return const Scaffold(
      body: Center(
        child: Text('Qubit'),
      ),
    );
  }

  _spashWork() async {
    final String? data = await LocalDatabase().getData();
    if (data != null && data.isNotEmpty) {
      apiKey = data;
      connections = await UserData().getCurrentUserData()??[];
      Get.off(const AllUsersScreen());
    } else {
      Get.off(const LoginScreen());
    }
  }
}
