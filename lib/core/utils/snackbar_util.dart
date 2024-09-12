import 'package:flutter/material.dart';

class SnackbarUtil {
  static void openSuccessSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Login Success'),
      backgroundColor: Colors.green,
      showCloseIcon: true,
    ));
  }

  static void openFailureSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        showCloseIcon: true,
        backgroundColor: Colors.red,
      ),
    );
  }
}
