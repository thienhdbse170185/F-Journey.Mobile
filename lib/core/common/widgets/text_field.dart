import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.labelText,
      this.isPassword = false,
      this.suffixIcon,
      this.validator,
      this.isObscure = false,
      this.helperText});
  final TextEditingController controller;
  final String labelText;
  final bool isPassword;
  final bool isObscure;
  final String? helperText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isObscure,
      keyboardType: widget.isPassword ? null : TextInputType.emailAddress,
      autocorrect: false,
      validator: widget.validator,
      enableSuggestions: false,
      decoration: InputDecoration(
          labelText: widget.labelText,
          helperText: widget.helperText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          suffixIcon: widget.suffixIcon),
    );
  }
}
