import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:f_journey/core/common/widgets/settings_bottom_sheet.dart';
import 'package:f_journey/core/router.dart';
import 'package:f_journey/core/utils/snackbar_util.dart';
import 'package:f_journey/features/auth/bloc/auth_bloc.dart';
import 'package:f_journey/features/auth/model/request/driver.dart';
import 'package:f_journey/features/auth/model/request/driver_register_request.dart';
import 'package:f_journey/features/auth/model/request/vehicle.dart';
import 'package:f_journey/features/auth/widgets/components/text_field_required.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _licenseNumberController =
      TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _licensePlateController = TextEditingController();
  XFile? _licenseCardImage;
  XFile? _registrationImage;
  XFile? _vehicleImage;
  XFile? _avatarImage;
  final ImagePicker _picker = ImagePicker();
  int _currentStep = 0;

  void submitForm() {
    // Gather data from text controllers
    String fullName = _fullNameController.text.trim();
    String phoneNumber = _phoneNumberController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();
    String licenseNumber = _licenseNumberController.text.trim();
    String expiryDate = _expiryDateController.text.trim();
    String dob = _dobController.text.trim();
    String licensePlate = _licensePlateController.text.trim();

    // Perform validation
    if (fullName.isEmpty ||
        phoneNumber.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        licenseNumber.isEmpty ||
        expiryDate.isEmpty ||
        dob.isEmpty ||
        _licenseCardImage == null ||
        _registrationImage == null ||
        _vehicleImage == null ||
        _avatarImage == null ||
        licensePlate.isEmpty) {
      // Show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('Please fill in all required fields and upload images.')),
      );
      return; // Exit if validation fails
    }

    // Additional validation for password confirmation
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match.')),
      );
      return;
    }

    // Proceed with form submission
    // For example, you might send this data to your backend API
    // Here is a placeholder for that logic:
    final request = RegisterDriverRequest(
      name: fullName,
      email: email,
      phoneNumber: phoneNumber,
      password: password,
      profileImage: _avatarImage,
      driver: Driver(
        licenseNumber: licenseNumber,
        verified: false,
        licenseImage: _licenseCardImage,
      ),
      vehicle: Vehicle(
        licensePlate: licensePlate,
        vehicleType: 'Xe máy',
        isVerified: false,
        registration: '123456',
        vehicleImage: _vehicleImage,
        registrationImage: _registrationImage,
      ),
    );

    try {
      context
          .read<AuthBloc>()
          .add(RegisterDriverProfileStarted(request: request));
    } catch (e) {
      // Handle any errors that occur during the API call
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
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

  Future<void> _pickImage(String imageType) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 500,
        maxWidth: 500,
      );

      if (pickedFile != null) {
        if (pickedFile.path.endsWith('.jpeg') ||
            pickedFile.path.endsWith('.jpg') ||
            pickedFile.path.endsWith('.png')) {
          setState(() {
            if (imageType == 'license') {
              _licenseCardImage = XFile(pickedFile.path);
            } else if (imageType == 'registration') {
              _registrationImage = XFile(pickedFile.path);
            } else if (imageType == 'vehicle') {
              _vehicleImage = XFile(pickedFile.path);
            } else if (imageType == 'avatar') {
              _avatarImage = XFile(pickedFile.path);
            }
          });
        } else {
          print('Unsupported file type');
        }
      }
    } catch (e) {
      print(e); // Handle errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is RegisterDriverProfileSuccess) {
          context.go(RouteName.registerResult);
        } else if (state is RegisterDriverProfileError) {
          SnackbarUtil.openFailureSnackbar(context, state.message);
        } else if (state is RegisterPassengerProfileInProgress) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Đợi xíu...")),
          );
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
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
                    // context.push(RouteName.registerResult); //ONLY FOR DEV UI
                    submitForm();
                  }
                });
              },
              child: _currentStep == 1
                  ? const Text('Mình đã sẵn sàng!')
                  : const Text('Tiếp tục'),
            ),
          )),
    );
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
                        onTap: () => _pickImage('license'),
                        child: SizedBox(
                            width: 120,
                            child: _licenseCardImage != null
                                ? Image.file(
                                    File(_licenseCardImage!.path),
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
                        onTap: () => _pickImage('registration'),
                        child: SizedBox(
                            width: 120,
                            child: _registrationImage != null
                                ? Image.file(
                                    File(_registrationImage!.path),
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
                        onTap: () => _pickImage('vehicle'),
                        child: SizedBox(
                            width: 120,
                            child: _vehicleImage != null
                                ? Image.file(
                                    File(_vehicleImage!.path),
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
              TextFieldRequired(
                label: 'License Number | Số giấy phép lái xe',
                hintText: 'Nhập số giấy phép lái xe',
                controller: _licenseNumberController,
              ),
              const SizedBox(height: 32),
              TextFieldRequired(
                label: 'License Plate | Biển số xe',
                hintText: 'Nhập biển số xe',
                controller: _licensePlateController,
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
                        onTap: () => _pickImage('avatar'),
                        child: SizedBox(
                            width: 120,
                            child: _avatarImage != null
                                ? Image.file(
                                    File(_avatarImage!.path),
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
              TextFieldRequired(
                label: 'Full Name | Họ và Tên',
                hintText: 'Nhập họ và tên',
                controller: _fullNameController,
              ),
              const SizedBox(height: 32),
              TextFieldRequired(
                label: 'Email',
                hintText: 'Nhập email',
                controller: _emailController,
              ),
              const SizedBox(height: 32),
              TextFieldRequired(
                label: 'Phone Number | Số điện thoại',
                hintText: 'Nhập số điện thoại',
                controller: _phoneNumberController,
              ),
              const SizedBox(height: 32),
              TextFieldRequired(
                label: 'Password | Mật khẩu',
                hintText: 'Nhập mật khẩu',
                obscureText: true,
                controller: _passwordController,
              ),
              const SizedBox(height: 32),
              TextFieldRequired(
                label: 'Confirm Password | Xác nhận mật khẩu',
                hintText: 'Nhập lại mật khẩu',
                obscureText: true,
                controller: _confirmPasswordController,
              ),
              const SizedBox(height: 96),
            ],
          ),
        ))
      ],
    );
  }
}
