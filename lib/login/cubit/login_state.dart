part of 'login_cubit.dart';

class LoginState extends Equatable {
  LoginState({
    this.formStatus = FormzSubmissionStatus.initial,
    this.isFormValid = false,
    this.errorMessage,
    this.successMessage,
    AuthRequest? authRequest,
  }) : authRequest = authRequest ??
            const AuthRequest(
                email: Email.dirty('blessingmwalein@gmail.com'),
                password: Password.dirty("Xbling1999"));

  final FormzSubmissionStatus formStatus;
  final bool isFormValid;
  final String? errorMessage;
  final String? successMessage;
  final AuthRequest authRequest;

  LoginState copyWith({
    FormzSubmissionStatus? formStatus,
    bool? isFormValid,
    String? errorMessage,
    String? successMessage,
    AuthRequest? authRequest,
  }) {
    return LoginState(
      formStatus: formStatus ?? this.formStatus,
      isFormValid: isFormValid ?? this.isFormValid,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      authRequest: authRequest ?? this.authRequest,
    );
  }

  @override
  List<Object?> get props => [
        formStatus,
        isFormValid,
        errorMessage,
        successMessage,
        authRequest,
      ];
}
