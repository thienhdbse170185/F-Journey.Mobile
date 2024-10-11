import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:f_journey/core/common/widgets/settings_bottom_sheet.dart';
import 'package:f_journey/core/router.dart';
import 'package:f_journey/features/auth/widgets/components/text_field_required.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class DriverRegisterWidget extends StatefulWidget {
  const DriverRegisterWidget({super.key});

  @override
  State<DriverRegisterWidget> createState() => _DriverRegisterWidgetState();
}

class _DriverRegisterWidgetState extends State<DriverRegisterWidget> {
  late DateTime _selectedExpiryDate;
  late DateTime _selectedDOB;
  TextEditingController _expiryDateController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  File? _studentCardImage;
  File? _avatarImage;
  final ImagePicker _picker = ImagePicker();
  int _currentStep = 0;

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

  Future<void> _pickImage(bool isStudentCard) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        if (isStudentCard) {
          _studentCardImage = File(pickedFile.path);
        } else {
          _avatarImage = File(pickedFile.path);
        }
      });
    }
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
              onPressed: () {
                showSettingsBottomSheet(context);
              },
            ),
          ],
        ),
        body: Column(
          children: [
            LinearProgressIndicator(
              borderRadius: BorderRadius.circular(8),
              value: (_currentStep + 1) / 2,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: _currentStep == 0
                      ? _buildDriverLicenseRegistration(context)
                      : _buildAccountRegistration(context),
                ),
              ),
            )
          ],
        ),
        bottomSheet: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          width: MediaQuery.of(context).size.width,
          child: FilledButton(
            onPressed: () {
              // context.go(RouteName.registerResult);
              // context.push(RouteName.registerResult); //ONLY FOR DEV
              setState(() {
                if (_currentStep < 1) {
                  _currentStep++;
                } else {
                  // context.go(RouteName.registerResult);
                  context.push(RouteName.registerResult); //ONLY FOR DEV UI
                }
              });
            },
            child: _currentStep == 1
                ? const Text('Mình đã sẵn sàng!')
                : const Text('Tiếp tục'),
          ),
        ));
  }

  Widget _buildDriverLicenseRegistration(BuildContext context) {
    return Column(
      children: [
        // Thẻ sinh viên
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                  text: TextSpan(
                      style: Theme.of(context).textTheme.titleLarge,
                      children: [
                    const TextSpan(text: 'Giấy phép lái xe '),
                    TextSpan(
                        text: '*',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.error))
                  ])),
              SizedBox(
                  width: 120,
                  height: 120,
                  child: DottedBorder(
                      color: Theme.of(context).colorScheme.outlineVariant,
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(12),
                      strokeWidth: 1,
                      child: InkWell(
                        onTap: () => _pickImage(true),
                        child: SizedBox(
                            width: 120,
                            child: _studentCardImage != null
                                ? Image.file(
                                    _studentCardImage!,
                                    fit: BoxFit.cover,
                                  )
                                : Column(
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
                                  )),
                      )))
            ],
          ),
        ),
        const SizedBox(height: 32),
        // Ảnh đại diện
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                  text: TextSpan(
                      style: Theme.of(context).textTheme.titleLarge,
                      children: [
                    const TextSpan(text: 'Cà vẹt xe '),
                    TextSpan(
                        text: '*',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.error))
                  ])),
              SizedBox(
                  width: 120,
                  height: 120,
                  child: DottedBorder(
                      color: Theme.of(context).colorScheme.outlineVariant,
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(12),
                      strokeWidth: 1,
                      child: InkWell(
                        onTap: () => _pickImage(false),
                        child: SizedBox(
                            width: 120,
                            child: _avatarImage != null
                                ? Image.file(
                                    _avatarImage!,
                                    fit: BoxFit.cover,
                                  )
                                : SizedBox(
                                    width: 120,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                    ))),
                      )))
            ],
          ),
        ),
        const SizedBox(height: 32),
        // Ảnh đại diện
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(
                          style: Theme.of(context).textTheme.titleLarge,
                          children: [
                        const TextSpan(text: 'Ảnh phương tiện '),
                        TextSpan(
                            text: '*',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.error))
                      ])),
                  Text('(Ảnh chụp phải có biển số xe)',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.outline)),
                ],
              ),
              SizedBox(
                  width: 120,
                  height: 120,
                  child: DottedBorder(
                      color: Theme.of(context).colorScheme.outlineVariant,
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(12),
                      strokeWidth: 1,
                      child: InkWell(
                        onTap: () => _pickImage(false),
                        child: SizedBox(
                            width: 120,
                            child: _avatarImage != null
                                ? Image.file(
                                    _avatarImage!,
                                    fit: BoxFit.cover,
                                  )
                                : SizedBox(
                                    width: 120,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                    ))),
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
                  label: 'License Number | Số giấy phép lái xe',
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
                  label: 'Full Name | Họ và Tên', hintText: 'Nhập họ và tên'),
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
                              color: Theme.of(context).colorScheme.error))
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
    );
  }

  Widget _buildAccountRegistration(BuildContext context) {
    return Column(
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
                      color: Theme.of(context).colorScheme.outlineVariant,
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(12),
                      strokeWidth: 1,
                      child: InkWell(
                        onTap: () => _pickImage(false),
                        child: SizedBox(
                            width: 120,
                            child: _avatarImage != null
                                ? Image.file(
                                    _avatarImage!,
                                    fit: BoxFit.cover,
                                  )
                                : SizedBox(
                                    width: 120,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                    ))),
                      )))
            ],
          ),
        ),
        const SizedBox(height: 32),
        Form(
            child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: const Column(
            children: [
              TextFieldRequired(
                  label: 'Full Name | Họ và Tên', hintText: 'Nhập họ và tên'),
              SizedBox(height: 32),
              TextFieldRequired(label: 'Email', hintText: 'Nhập email'),
              SizedBox(height: 32),
              TextFieldRequired(
                  label: 'Phone Number | Số điện thoại',
                  hintText: 'Nhập số điện thoại'),
              SizedBox(height: 32),
              TextFieldRequired(
                label: 'Password | Mật khẩu',
                hintText: 'Nhập mật khẩu',
                obscureText: true,
              ),
              SizedBox(height: 32),
              TextFieldRequired(
                label: 'Confirm Password | Xác nhận mật khẩu',
                hintText: 'Nhập lại mật khẩu',
                obscureText: true,
              ),
              SizedBox(height: 96),
            ],
          ),
        ))
      ],
    );
  }
}
