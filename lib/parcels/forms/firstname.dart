import 'package:formz/formz.dart';

enum FirstnameValidationError { invalid }

class Firstname extends FormzInput<String, FirstnameValidationError> {
  const Firstname.pure() : super.pure('');
  const Firstname.dirty([super.value = '']) : super.dirty();

  static final RegExp _firstnameRegExp = RegExp(r"^[a-zA-Z\s]+$");

  @override
  FirstnameValidationError? validator(String? value) {
    return _firstnameRegExp.hasMatch(value ?? '')
        ? null
        : FirstnameValidationError.invalid;
  }
}
