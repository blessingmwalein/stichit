import 'package:formz/formz.dart';

/// Validation errors for the [PhoneNumber] [FormzInput].
enum PhoneNumberValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template phoneNumber}
/// Form input for a phone number input.
/// {@endtemplate}
class PhoneNumber extends FormzInput<String, PhoneNumberValidationError> {
  /// {@macro phoneNumber}
  const PhoneNumber.pure() : super.pure('');

  /// {@macro phoneNumber}
  const PhoneNumber.dirty([super.value = '']) : super.dirty();

  static final RegExp _phoneNumberRegExp = RegExp(
    r'^[0-9]+$',
  );

  @override
  PhoneNumberValidationError? validator(String? value) {
    return _phoneNumberRegExp.hasMatch(value ?? '')
        ? null
        : PhoneNumberValidationError.invalid;
  }
}
