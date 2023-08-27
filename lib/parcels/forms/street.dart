import 'package:formz/formz.dart';

enum StreetValidationError { invalid }

class Street extends FormzInput<String, StreetValidationError> {
  const Street.pure() : super.pure('');
  const Street.dirty([super.value = '']) : super.dirty();

  static final RegExp _streetRegExp = RegExp(r"^[a-zA-Z\s.]+$");

  @override
  StreetValidationError? validator(String? value) {
    return _streetRegExp.hasMatch(value ?? '')
        ? null
        : StreetValidationError.invalid;
  }
}
