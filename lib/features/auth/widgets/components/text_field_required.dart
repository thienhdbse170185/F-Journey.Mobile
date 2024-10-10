import 'package:flutter/material.dart';

class TextFieldRequired extends StatefulWidget {
  const TextFieldRequired(
      {super.key,
      required this.label,
      required this.hintText,
      this.suffixIcon,
      this.onTap,
      this.isDisabled,
      this.controller});

  final String label;
  final String hintText;
  final Icon? suffixIcon;
  final VoidCallback? onTap;
  final bool? isDisabled;
  final TextEditingController? controller;

  @override
  State<TextFieldRequired> createState() => _TextFieldRequiredState();
}

class _TextFieldRequiredState extends State<TextFieldRequired> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      autocorrect: false,
      controller: widget.controller,
      focusNode: widget.isDisabled == true ? AlwaysDisabledFocusNode() : null,
      onTap: widget.onTap,
      decoration: InputDecoration(
        label: RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyMedium,
            children: [
              TextSpan(text: '${widget.label} '),
              TextSpan(
                  text: '*',
                  style: TextStyle(color: Theme.of(context).colorScheme.error))
            ],
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        hintText: widget.hintText,
        suffixIcon: widget.suffixIcon,
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
