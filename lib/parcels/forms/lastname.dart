import 'package:formz/formz.dart';

enum LastnameValidationError { invalid }

class Lastname extends FormzInput<String, LastnameValidationError> {
  const Lastname.pure() : super.pure('');
  const Lastname.dirty([super.value = '']) : super.dirty();

  static final RegExp _lastnameRegExp = RegExp(r"^[a-zA-Z]+$");

  @override
  LastnameValidationError? validator(String? value) {
    return _lastnameRegExp.hasMatch(value ?? '')
        ? null
        : LastnameValidationError.invalid;
  }
}
