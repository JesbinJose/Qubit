import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomNoteWithTextButton extends StatelessWidget {
  const CustomNoteWithTextButton({
    super.key,
    required this.route,
    required this.note,
    required this.button,
  });
  final String route;
  final String note;
  final String button;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(note),
        const SizedBox(width: 5),
        TextButton(
          style: const ButtonStyle(
            padding: MaterialStatePropertyAll(
              EdgeInsets.zero,
            ),
          ),
          onPressed: () {
            Get.offNamed(route);
          },
          child: Text(
            button,
          ),
        ),
      ],
    );
  }
}
