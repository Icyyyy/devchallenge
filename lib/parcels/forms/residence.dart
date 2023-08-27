import 'package:formz/formz.dart';

enum ResidenceValidationError { invalid }

class Residence extends FormzInput<String, ResidenceValidationError> {
  const Residence.pure() : super.pure('');
  const Residence.dirty([super.value = '']) : super.dirty();

  static final RegExp _residenceRegExp = RegExp(r"^[a-zA-Z\s]+$");

  @override
  ResidenceValidationError? validator(String? value) {
    return _residenceRegExp.hasMatch(value ?? '')
        ? null
        : ResidenceValidationError.invalid;
  }
}
