import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:f_journey/core/common/widgets/settings_bottom_sheet.dart';
import 'package:f_journey/core/router.dart';
import 'package:f_journey/core/utils/snackbar_util.dart';
import 'package:f_journey/features/auth/bloc/auth_bloc.dart';
import 'package:f_journey/features/auth/model/request/passenger_register_request.dart';
import 'package:f_journey/features/auth/model/response/get_user_profile_response.dart';
import 'package:f_journey/features/auth/widgets/components/text_field_required.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class PassengerRegistrationWidget extends StatefulWidget {
  final GetUserProfileResult? userProfile;

  const PassengerRegistrationWidget({super.key, this.userProfile});

  @override
  State<PassengerRegistrationWidget> createState() =>
      _PassengerRegistrationWidgetState();
}

class _PassengerRegistrationWidgetState
    extends State<PassengerRegistrationWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late DateTime _selectedExpiryDate;
  late DateTime _selectedDOB;
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _studentCardIdController =
      TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  XFile? _studentCardImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();

    // Preload avatar and name if provided
    if (widget.userProfile?.name != null) {
      _fullNameController.text = widget.userProfile!.name;
    }
  }

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

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 500,
        maxWidth: 500,
      );

      if (pickedFile != null) {
        if (pickedFile.path.endsWith('.jpeg') ||
            pickedFile.path.endsWith('.jpg')) {
          setState(() {
            _studentCardImage = XFile(pickedFile.path);
          });
        } else {
          print('Unsupported file type');
        }
      }
    } catch (e) {
      print(e); // Handle errors
    }
  }

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      final name = _fullNameController.text.trim();
      final phone = _phoneNumberController.text.trim();

      final request = PassengerRegisterRequest(
          id: widget.userProfile!.id,
          name: name,
          email: widget.userProfile!.email,
          phoneNumber: phone,
          profileImageUrl: widget.userProfile!.profileImageUrl,
          studentIdCardUrl: _studentCardImage!,
          studentId: _studentCardIdController.text.trim());
      try {
        context
            .read<AuthBloc>()
            .add(RegisterPassengerProfileStarted(request: request));
      } catch (e) {
        print('Error creating user profile: $e');
        SnackbarUtil.openFailureSnackbar(
            context, 'Failed to create user profile');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is RegisterPassengerProfileSuccess) {
          context.go(RouteName.registerResult);
        } else if (state is RegisterPassengerProfileError) {
          SnackbarUtil.openFailureSnackbar(context, state.message);
        } else if (state is RegisterPassengerProfileInProgress) {
          SnackbarUtil.openSuccessSnackbar(context, 'Đợi một chút...');
        }
      },
      child: Scaffold(
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
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  children: [
                    // Display Avatar
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                  text: TextSpan(
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                      children: [
                                    const TextSpan(text: 'Ảnh đại diện '),
                                    TextSpan(
                                        text: '*',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .error))
                                  ])),
                              SizedBox(
                                  width: 120,
                                  height: 120,
                                  child: DottedBorder(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .outlineVariant,
                                      borderType: BorderType.RRect,
                                      radius: const Radius.circular(12),
                                      strokeWidth: 1,
                                      child: InkWell(
                                        onTap: () => _pickImage(),
                                        child: SizedBox(
                                            width: 120,
                                            child: widget.userProfile!
                                                        .profileImageUrl !=
                                                    null
                                                ? Image.network(
                                                    widget.userProfile!
                                                        .profileImageUrl,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Icon(Icons.add),
                                                      const SizedBox(height: 8),
                                                      Text(
                                                        'Tải ảnh lên',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall
                                                            ?.copyWith(
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .outline),
                                                      ),
                                                    ],
                                                  )),
                                      )))
                            ])),
                    const SizedBox(height: 32),
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
                                const TextSpan(text: 'Thẻ Sinh Viên '),
                                TextSpan(
                                    text: '*',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .error))
                              ])),
                          SizedBox(
                              width: 120,
                              height: 120,
                              child: DottedBorder(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .outlineVariant,
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(12),
                                  strokeWidth: 1,
                                  child: InkWell(
                                    onTap: () => _pickImage(),
                                    child: SizedBox(
                                        width: 120,
                                        child: _studentCardImage != null
                                            ? Image.file(
                                                File(_studentCardImage!.path),
                                                fit: BoxFit.cover,
                                              )
                                            : Column(
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
                                                            color: Theme.of(
                                                                    context)
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
                    Form(
                        child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          TextFieldRequired(
                            label: 'Student Card ID | Mã số Thẻ Sinh Viên',
                            hintText: 'Nhập mã số thẻ sinh viên',
                            controller: _studentCardIdController,
                          ),
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
                          TextFieldRequired(
                            label: 'Full Name | Họ và Tên',
                            hintText: 'Nhập họ và tên',
                            controller: _fullNameController,
                          ),
                          const SizedBox(height: 32),
                          TextFieldRequired(
                            label: 'Phone Number | Số điện thoại',
                            hintText: 'Nhập số điện thoại',
                            controller: _phoneNumberController,
                          ),
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
                                          color: Theme.of(context)
                                              .colorScheme
                                              .error))
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
          ),
          bottomSheet: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            width: MediaQuery.of(context).size.width,
            child: FilledButton(
              onPressed: () {
                // context.push(RouteName.registerResult);
                _submitForm();
              },
              child: const Text('Mình đã sẵn sàng!'),
            ),
          )),
    );
  }
}
