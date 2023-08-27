import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormTextField extends StatelessWidget {
  const FormTextField({
    super.key,
    required this.onChanged,
    required this.initialValue,
    required this.labelText,
    this.errorText,
    this.inputFormatters,
    this.keyboardType,
  });

  final ValueChanged<String> onChanged;
  final String labelText;
  final String initialValue;
  final String? errorText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
        errorText: errorText,
      ),
    );
  }
}
