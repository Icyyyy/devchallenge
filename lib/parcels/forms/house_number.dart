import 'package:formz/formz.dart';

enum HouseNumberValidationError { invalid }

class HouseNumber extends FormzInput<String, HouseNumberValidationError> {
  const HouseNumber.pure() : super.pure('');
  const HouseNumber.dirty([super.value = '']) : super.dirty();

  static final RegExp _houseNumberRegExp = RegExp(r"^[0-9a-z]+$");
  @override
  HouseNumberValidationError? validator(String? value) {
    return _houseNumberRegExp.hasMatch(value ?? '')
        ? null
        : HouseNumberValidationError.invalid;
  }
}
