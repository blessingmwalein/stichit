import 'package:formz/formz.dart';

/// Validation errors for the [Address] [FormzInput].
enum AddressValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template address}
/// Form input for an address input.
/// {@endtemplate}
class Address extends FormzInput<String, AddressValidationError> {
  /// {@macro address}
  const Address.pure() : super.pure('');

  /// {@macro address}
  const Address.dirty([super.value = '']) : super.dirty();

  static final RegExp _addressRegExp = RegExp(
    r'^[a-zA-Z0-9\s]+$',
  );

  @override
  AddressValidationError? validator(String? value) {
    return _addressRegExp.hasMatch(value ?? '')
        ? null
        : AddressValidationError.invalid;
  }
}
