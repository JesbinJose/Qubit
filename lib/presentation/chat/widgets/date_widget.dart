import 'package:flutter/material.dart';
import 'package:qubit/model/message.dart';
import 'package:qubit/utils/time.dart';

class DateWidget extends StatelessWidget {
  const DateWidget({
    super.key,
    required this.message,
    required this.time,
    required this.index,
  });

  final Message message;
  final DateTime? time;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: index == 0 ||
          _showDateOrNot(
            message.time,
            time,
          ),
      child: Align(
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
          color: Colors.black,
          ),
          child: Text(
            formatDateTime(
              message.time,
            ),
          ),
        ),
      ),
    );
  }

  bool _showDateOrNot(DateTime current, DateTime? next) {
    bool res = (current.day != next?.day || current.month != next?.month);
    if (res) {
      return true;
    } else {
      return false;
    }
  }
}
