import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';

/// {@template auth_request}
/// AuthRequest model for user authentication
/// {@endtemplate}
class AuthRequest extends Equatable {
  /// {@macro auth_request}
  const AuthRequest({
    required this.email,
    required this.password,
  });

  /// The user's email.p
  final Email email;

  /// The user's password.
  final Password password;

  /// Convenience getter to determine whether the auth request is valid.
  bool get isValid => email.error == null && password.error == null;

  /// Creates a copy of the AuthRequest with the specified fields replaced with new values.
  AuthRequest copyWith({
    Email? email,
    Password? password,
  }) {
    return AuthRequest(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  /// Returns a copy of the AuthRequest instance with a specific field replaced with a new value.
  AuthRequest copyWithField(String field, dynamic value) {
    switch (field) {
      case 'email':
        final email = Email.dirty(value);
        return copyWith(email: email);
      case 'password':
        final password = Password.dirty(value);
        return copyWith(password: password);
      default:
        return this;
    }
  }

  /// Converts the AuthRequest instance to a JSON object.
  Map<String, dynamic> toJson() {
    return {
      'email': email.value,
      'password': password.value,
    };
  }

  /// Creates an AuthRequest instance from a JSON object.
  factory AuthRequest.fromJson(Map<String, dynamic> json) {
    return AuthRequest(
      email: Email.dirty(json['email'] ?? ''),
      password: Password.dirty(json['password'] ?? ''),
    );
  }

  @override
  List<Object?> get props => [email, password];
}
