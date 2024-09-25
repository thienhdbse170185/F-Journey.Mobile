import 'package:flutter/material.dart';

class RoleSelectionWidget extends StatefulWidget {
  const RoleSelectionWidget(
      {super.key,
      required this.textTheme,
      required this.onSubmit,
      required this.onToggle});

  final TextTheme textTheme;
  final VoidCallback onSubmit;
  final VoidCallback onToggle;

  @override
  State<RoleSelectionWidget> createState() => _RoleSelectionWidgetState();
}

class _RoleSelectionWidgetState extends State<RoleSelectionWidget> {
  final TextEditingController studentIdController = TextEditingController();
  final TextEditingController licenseNumberController = TextEditingController();
  bool isDriver = false;
  bool isPassenger = false;
  bool isStudentIdRequired = false;
  String? selectedAvatar;
  String? selectedStudentCardImage;
  String? selectedLicenseImage;
  String? selectedVehicleImage;

  bool get isRoleSelected => isDriver || isPassenger;

  void _submit() {
    if (!isRoleSelected) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a role.')),
      );
      return;
    }
    if ((isPassenger &&
            (studentIdController.text.isEmpty ||
                selectedStudentCardImage == null)) ||
        (isDriver &&
            (licenseNumberController.text.isEmpty ||
                selectedLicenseImage == null ||
                selectedVehicleImage == null))) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete all required fields.')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Processing Role Selection')),
    );
    widget.onSubmit();
  }

  void _selectRole(bool driverSelected) {
    setState(() {
      isDriver = driverSelected;
      isPassenger = !driverSelected;
      isStudentIdRequired = !driverSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    String greetingText = 'Hi ^^';
    String instructionText = 'Select your role to join our journey';

    if (isPassenger) {
      greetingText = 'Hi, passenger ^^';
      instructionText = 'Please provide us your detail information';
    } else if (isDriver) {
      greetingText = 'Hi, driver ^^';
      instructionText = 'Please provide us your driver details';
    }

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
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
            Text(greetingText,
                style: widget.textTheme.headlineLarge?.copyWith(fontSize: 28)),
            const SizedBox(height: 16),
            Text(
              instructionText,
              style: widget.textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 22),

            // Role selection buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildRoleButton(
                    'Passenger', isPassenger, () => _selectRole(false)),
                const SizedBox(width: 16),
                _buildRoleButton('Driver', isDriver, () => _selectRole(true)),
              ],
            ),
            const SizedBox(height: 24),

            // Additional fields for Passenger
            if (isPassenger) ...[
              TextField(
                controller: studentIdController,
                decoration: const InputDecoration(
                  labelText: 'Student ID',
                  helperText: 'Required for passengers',
                ),
              ),
              const SizedBox(height: 24),
              // Upload student card image
              TextButton(
                onPressed: () {
                  // Implement image picker for student card image
                },
                child: const Text('Upload Student Card Image (required)'),
              ),
              const SizedBox(height: 24),
              // Upload avatar image or use default
              TextButton(
                onPressed: () {
                  // Implement image picker for avatar
                },
                child: const Text('Upload Avatar Image (Optional)'),
              ),
            ],

            // Additional fields for Driver
            if (isDriver) ...[
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
            ],

            const SizedBox(height: 32),
            // Submit button, disabled if no role is selected
            ElevatedButton(
              // onPressed: isRoleSelected ? _submit : null,
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                // Đổi màu của nút khi disabled thành màu tím nhạt
                backgroundColor: isRoleSelected
                    ? Colors.purple.shade400
                    : Colors.purple.shade100,
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

  // Custom role button widget
  Widget _buildRoleButton(String title, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? Colors.purple.shade300 : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.purple.shade300),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.3),
                    blurRadius: 10.0,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.purple.shade300,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
