import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qubit/utils/cache.dart';
import 'package:qubit/features/local_data/save_credentials.dart';
import 'package:qubit/features/user/users_data.dart';

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
      try {
        apiKey = data;
        connections = await UserData().getCurrentUserData() ?? [];
        Get.offNamed('/home');
      } catch (e) {
        Get.offNamed('/login');
      }
    } else {
      Get.offNamed('/login');
    }
  }
}
