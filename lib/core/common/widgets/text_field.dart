import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.isPassword = false,
    this.suffixIcon,
    this.validator,
    this.isObscure = false,
    this.helperText,
    this.autofocus = false,
    this.maxLength,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String labelText;
  final bool isPassword;
  final bool isObscure;
  final String? helperText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final bool autofocus;
  final int? maxLength;
  final TextInputType? keyboardType;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isObscure;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      keyboardType: widget.keyboardType ??
          (widget.isPassword
              ? TextInputType.visiblePassword
              : TextInputType.text),
      autocorrect: false,
      validator: widget.validator,
      enableSuggestions: !widget.isPassword,
      autofocus: widget.autofocus,
      maxLength: widget.maxLength,
      decoration: InputDecoration(
        labelText: widget.labelText,
        helperText: widget.helperText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : widget.suffixIcon,
      ),
    );
  }
}
