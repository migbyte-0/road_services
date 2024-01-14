import 'package:flutter/material.dart';

class DialogUtils {
  static void showErrorDialog({
    required BuildContext context,
    required String msg,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(msg),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Ok'))
        ],
      ),
    );
  }

  static void showModalSheet({
    required BuildContext context,
    required String msg,
  }) {
    showModalBottomSheet(
      elevation: 5,
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Text(msg),
      ),
    );
  }

  static void showLoadingDialog({
    required BuildContext context,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        content: SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  static Future<void> showConfirmationDialog({
    required BuildContext context,
    required String title,
    required String content,
  }) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
