import 'package:flutter/material.dart';

class NavigationUtils {
  static void navigateTo({
    required BuildContext context,
    required Widget page,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  static Future<T?> pushAndRemoveUntil<T extends Object>({
    required BuildContext context,
    required Widget page,
  }) {
    return Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => page),
      (Route<dynamic> route) => false,
    );
  }

  static void pop(BuildContext context, [result]) {
    Navigator.pop(context, result);
  }
}
