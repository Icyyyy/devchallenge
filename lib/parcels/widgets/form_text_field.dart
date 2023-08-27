import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormTextField extends StatelessWidget {
  const FormTextField({
    super.key,
    this.onChanged,
    this.labelText,
    this.errorText,
    this.inputFormatters,
    this.keyboardType,
  });

  final ValueChanged<String>? onChanged;
  final String? labelText;
  final String? errorText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
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
