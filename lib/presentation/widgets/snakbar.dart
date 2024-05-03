import 'package:get/get.dart';

showCustomSnakbar(String title, String data) {
  Get.showSnackbar(
    GetSnackBar(
      title: title,
      message: data,
    ),
  );
}
