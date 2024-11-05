import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class ThemeCubit extends Cubit<bool> {
  ThemeCubit() : super(false); // false for light mode by default

  // Function to toggle between light and dark modes
  void toggleTheme() {
    emit(!state); // Emit the opposite of the current state
  }

  // Getter to convert the boolean state to ThemeMode
  ThemeMode get themeMode => state ? ThemeMode.dark : ThemeMode.light;
}
