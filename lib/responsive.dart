import 'package:flutter/cupertino.dart';

class Responsive {
  static Widget build(
    BuildContext context, {
    required Widget? sm,
    required Widget? me,
    required Widget? la,
  }) {
    final size = MediaQuery.of(context).size;
    if (size.width > 700 && la != null) {
      return la;
    } else if (size.width > 500 && me != null) {
      return me;
    } else if (sm != null) {
      return sm;
    } else {
      return const SizedBox();
    }
  }
}
