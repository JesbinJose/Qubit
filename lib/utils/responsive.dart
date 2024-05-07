import 'package:flutter/cupertino.dart';

class Responsive {
  static Widget build(
    BuildContext context, {
    required Widget? sm,
    required Widget? me,
    required Widget? la,
  }) {
    final size = MediaQuery.of(context).size;
    if (size.width > 800 && la != null) {
      return la;
    } else if (size.width > 600 && me != null) {
      return me;
    } else if (sm != null) {
      return sm;
    } else {
      return const SizedBox();
    }
  }
  static bool isMobile(BuildContext context){
    return MediaQuery.of(context).size.width < 500;
  }
}
