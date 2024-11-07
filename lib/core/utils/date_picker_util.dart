// lib/utils/date_picker_util.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<void> showDatePickerDialog({
  required BuildContext context,
  required TextEditingController controller,
  required DateTime initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
  required Function(DateTime) onDateSelected,
}) async {
  final selectedDate = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: firstDate ?? DateTime(2024, 1),
    lastDate: lastDate ?? DateTime(2030, 12),
  );

  if (selectedDate != null) {
    controller.text = DateFormat('yyyy-MM-dd').format(selectedDate);
    onDateSelected(selectedDate);
  }
}

Future<void> showTimeDialog({
  required BuildContext context,
  required TextEditingController controller,
  required TimeOfDay initialTime,
  required Function(TimeOfDay) onTimeSelected,
}) async {
  final selectedTime = await showTimePicker(
    context: context,
    initialTime: initialTime,
  );

  if (selectedTime != null) {
    // Convert TimeOfDay to DateTime for formatting
    final now = DateTime.now();
    final formattedTime = DateTime(
      now.year,
      now.month,
      now.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    // Format as "HH:mm:ss" and update the controller
    controller.text = DateFormat('HH:mm:ss').format(formattedTime);

    // Trigger the callback with the selected TimeOfDay
    onTimeSelected(selectedTime);
  }
}
