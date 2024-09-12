import 'package:flutter/material.dart';

class KeyboardUtil {
  static void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
