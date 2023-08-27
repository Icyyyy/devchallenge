import 'package:formz/formz.dart';

enum StreetValidationError { invalid }

class Street extends FormzInput<String, StreetValidationError> {
  const Street.pure() : super.pure('');
  const Street.dirty([super.value = '']) : super.dirty();

  // allow umlauts for streets, for e.g. "Überseestraße".
  static final RegExp _streetRegExp = RegExp(r"^[a-zA-Z\s.äöüÄÖÜß]+$");

  @override
  StreetValidationError? validator(String? value) {
    return _streetRegExp.hasMatch(value ?? '')
        ? null
        : StreetValidationError.invalid;
  }
}
