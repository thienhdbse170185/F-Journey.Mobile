import 'package:dotted_border/dotted_border.dart';
import 'package:f_journey/features/auth/widgets/components/text_field_required.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class PassengerRegistrationWidget extends StatefulWidget {
  const PassengerRegistrationWidget({super.key});

  @override
  State<PassengerRegistrationWidget> createState() =>
      _PassengerRegistrationWidgetState();
}

class _PassengerRegistrationWidgetState
    extends State<PassengerRegistrationWidget> {
  late DateTime _selectedExpiryDate;
  late DateTime _selectedDOB;
  TextEditingController _expiryDateController = TextEditingController();
  TextEditingController _dobController = TextEditingController();

  _selectExpiryDate(BuildContext context) async {
    await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2024, 1),
            lastDate: DateTime(2030, 12))
        .then((selectedDate) {
      if (selectedDate != null) {
        setState(() {
          _selectedExpiryDate = selectedDate;
        });
        _expiryDateController
          ..text = DateFormat.yMMMd().format(_selectedExpiryDate)
          ..selection = TextSelection.fromPosition(TextPosition(
              offset: _expiryDateController.text.length,
              affinity: TextAffinity.upstream));
      }
    });
  }

  _selectDOB(BuildContext context) async {
    await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900, 1),
            lastDate: DateTime(2024, 12))
        .then((selectedDate) {
      if (selectedDate != null) {
        setState(() {
          _selectedDOB = selectedDate;
        });
        _dobController
          ..text = DateFormat.yMMMd().format(_selectedDOB)
          ..selection = TextSelection.fromPosition(TextPosition(
              offset: _dobController.text.length,
              affinity: TextAffinity.upstream));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.pop();
            },
          ),
          title: const Text('Đăng ký'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                          text: TextSpan(
                              style: Theme.of(context).textTheme.titleLarge,
                              children: [
                            const TextSpan(text: 'Thẻ Sinh Viên '),
                            TextSpan(
                                text: '*',
                                style: TextStyle(
                                    color: Theme.of(context).colorScheme.error))
                          ])),
                      SizedBox(
                          width: 120,
                          height: 120,
                          child: DottedBorder(
                              color:
                                  Theme.of(context).colorScheme.outlineVariant,
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(12),
                              strokeWidth: 1,
                              child: SizedBox(
                                width: 120,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.add),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Tải ảnh lên',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .outline),
                                    ),
                                  ],
                                ),
                              )))
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                          text: TextSpan(
                              style: Theme.of(context).textTheme.titleLarge,
                              children: [
                            const TextSpan(text: 'Ảnh đại diện '),
                            TextSpan(
                                text: '*',
                                style: TextStyle(
                                    color: Theme.of(context).colorScheme.error))
                          ])),
                      SizedBox(
                          width: 120,
                          height: 120,
                          child: DottedBorder(
                              color:
                                  Theme.of(context).colorScheme.outlineVariant,
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(12),
                              strokeWidth: 1,
                              child: SizedBox(
                                width: 120,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.add),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Tải ảnh lên',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .outline),
                                    ),
                                  ],
                                ),
                              )))
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Form(
                    child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      const TextFieldRequired(
                          label: 'Student Card ID | Mã số Thẻ Sinh Viên',
                          hintText: 'Nhập mã số thẻ sinh viên'),
                      const SizedBox(height: 32),
                      TextFieldRequired(
                        label: 'Expiry Date | Ngày hết hạn',
                        hintText: 'Chọn ngày hết hạn',
                        suffixIcon: const Icon(Icons.calendar_month),
                        isDisabled: true,
                        onTap: () {
                          _selectExpiryDate(context);
                        },
                        controller: _expiryDateController,
                      ),
                      const SizedBox(height: 32),
                      const TextFieldRequired(
                          label: 'Full Name | Họ và Tên',
                          hintText: 'Nhập họ và tên'),
                      const SizedBox(height: 32),
                      const TextFieldRequired(
                          label: 'Phone Number | Số điện thoại',
                          hintText: 'Nhập số điện thoại'),
                      const SizedBox(height: 32),
                      DropdownMenu(
                        label: RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: [
                              const TextSpan(text: 'Gender | Giới tính '),
                              TextSpan(
                                  text: '*',
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.error))
                            ],
                          ),
                        ),
                        dropdownMenuEntries: const [
                          DropdownMenuEntry(value: 'Nam', label: 'Nam'),
                          DropdownMenuEntry(value: 'Nữ', label: 'Nữ'),
                          DropdownMenuEntry(value: 'Khác', label: 'Khác'),
                        ],
                        width: MediaQuery.of(context).size.width - 32,
                      ),
                      const SizedBox(height: 32),
                      TextFieldRequired(
                        label: 'DOB | Ngày sinh',
                        hintText: 'Chọn ngày sinh',
                        suffixIcon: const Icon(Icons.calendar_month),
                        isDisabled: true,
                        onTap: () {
                          _selectDOB(context);
                        },
                        controller: _dobController,
                      ),
                      const SizedBox(height: 96),
                    ],
                  ),
                ))
              ],
            ),
          ),
        ),
        bottomSheet: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          width: MediaQuery.of(context).size.width,
          child: const FilledButton(
            onPressed: null,
            child: Text('Mình đã sẵn sàng!'),
          ),
        ));
  }
}
