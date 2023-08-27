import 'package:formz/formz.dart';

enum PostCodeValidationError { invalid }

class PostCode extends FormzInput<String, PostCodeValidationError> {
  const PostCode.pure() : super.pure('');
  const PostCode.dirty([super.value = '']) : super.dirty();

  static final RegExp _postCodeRegExp = RegExp(
    r'^[0-9]{1,5}$',
  );

  @override
  PostCodeValidationError? validator(String? value) {
    return _postCodeRegExp.hasMatch(value ?? '')
        ? null
        : PostCodeValidationError.invalid;
  }
}
