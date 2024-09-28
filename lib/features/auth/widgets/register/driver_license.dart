import 'package:f_journey/core/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DriverLicenseRegisterWidget extends StatefulWidget {
  const DriverLicenseRegisterWidget(
      {super.key,
      required this.textTheme,
      required this.onSubmit,
      required this.onToggle});

  final TextTheme textTheme;
  final VoidCallback onSubmit;
  final VoidCallback onToggle;

  @override
  State<DriverLicenseRegisterWidget> createState() =>
      _DriverLicenseRegisterWidgetState();
}

class _DriverLicenseRegisterWidgetState
    extends State<DriverLicenseRegisterWidget> {
  final TextEditingController licenseNumberController = TextEditingController();
  String? selectedAvatar;
  String? selectedLicenseImage;
  String? selectedVehicleImage;

  void _submit() {
    // if (licenseNumberController.text.isEmpty ||
    //     selectedLicenseImage == null ||
    //     selectedVehicleImage == null) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Please complete all required fields.')),
    //   );
    //   return;
    // }

    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(content: Text('Processing Driver Registration')),
    // );
    // widget.onSubmit();
    context.push(RouteName.register);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        // padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        padding:
            const EdgeInsets.only(top: 32, right: 16, bottom: 24, left: 16),
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10.0,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Hi, driver ^^',
                style: widget.textTheme.headlineLarge?.copyWith(fontSize: 28)),
            const SizedBox(height: 16),
            Text(
              'Please provide us your driver details',
              style: widget.textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 32),
            // License Number Field
            TextField(
              controller: licenseNumberController,
              decoration: const InputDecoration(
                labelText: 'License Number',
                helperText: 'Required for drivers',
              ),
            ),
            const SizedBox(height: 24),

            // Upload driver's license image
            TextButton(
              onPressed: () {
                // Implement image picker for license image
              },
              child: const Text('Upload Driver’s License Image (required)'),
            ),
            const SizedBox(height: 24),

            // Upload vehicle image
            TextButton(
              onPressed: () {
                // Implement image picker for vehicle image
              },
              child: const Text('Upload Vehicle Image (required)'),
            ),

            const SizedBox(height: 32),

            // Submit button
            ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.purple.shade400,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text(
                'Submit',
                style: widget.textTheme.displaySmall?.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Option to go back to login
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: widget.textTheme.bodyMedium?.copyWith(
                    color: Colors.black54,
                  ),
                ),
                TextButton(
                  onPressed: widget.onToggle,
                  child: Text(
                    'Log In',
                    style: widget.textTheme.bodyMedium?.copyWith(
                      color: Colors.purple.shade300,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
