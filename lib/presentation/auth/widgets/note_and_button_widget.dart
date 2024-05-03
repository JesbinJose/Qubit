import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomNoteWithTextButton extends StatelessWidget {
  const CustomNoteWithTextButton({
    super.key,
    required this.widget,
    required this.note,
    required this.button,
  });
  final Widget widget;
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
            Get.off(widget);
          },
          child: Text(
            button,
          ),
        ),
      ],
    );
  }
}
