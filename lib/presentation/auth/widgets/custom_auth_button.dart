import 'package:flutter/material.dart';

class CustomAuthButton extends StatelessWidget {
  const CustomAuthButton({
    super.key,
    required this.onTap,
    required this.widget,
  });
  final Function() onTap;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minWidth: 220,maxHeight: double.infinity),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(),
        ),
        height: 50,
        child: Center(
          child: widget,
        ),
      ),
    );
  }
}
