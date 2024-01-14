import 'package:flutter/material.dart';

class SnackBarUtils {
  static void showSnackBar({
    required BuildContext context,
    required String msg,
    Color color = Colors.red,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: color,
      ),
    );
  }
}
