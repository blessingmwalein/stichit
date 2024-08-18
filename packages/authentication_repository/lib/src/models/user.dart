import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';

/// {@template user}
/// UserModel model
///
/// [UserModel.empty] represents an unauthenticated user.
/// {@endtemplate}
class UserModel extends Equatable {
  /// {@macro user}
  const UserModel({
    required this.id,
    this.email,
    this.fullName,
    this.photo,
    this.address,
    this.gender,
    this.mobile,
    this.confirmPassword,
    this.password,
    this.isAdmin = false, // Default value for isAdmin
  });

  /// The current user's email.
  final Email? email;

  /// The current user's id.
  final String id;

  /// The current user's full name.
  final String? fullName;

  /// The current user's gender.
  final String? gender;

  /// The current user's mobile number.
  final PhoneNumber? mobile;

  /// The current user's address.
  final String? address;

  /// The current user's password.
  final Password? password;

  /// The current user's confirm password.
  final Password? confirmPassword;

  /// URL for the current user's photo.
  final String? photo;

  /// Indicates if the user is an admin.
  final bool isAdmin;

  /// Empty user which represents an unauthenticated user.
  static const empty = UserModel(id: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == UserModel.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != UserModel.empty;

  /// Creates a UserModel instance from Firestore document snapshot.
  factory UserModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return UserModel(
      id: snapshot.id,
      email: data['email'] != null ? Email.dirty(data['email']) : null,
      fullName: data['full_name'],
      photo: data['photo'],
      address: data['address'],
      gender: data['gender'],
      mobile: data['mobile'] != null ? PhoneNumber.dirty(data['mobile']) : null,
      isAdmin: data['is_admin'] ?? false, // Default to false if not set
    );
  }

  /// Creates a UserModel instance from a JSON map.
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email:
          json['email'] != null ? Email.dirty(json['email'] as String) : null,
      fullName: json['full_name'] as String?,
      photo: json['photo'] as String?,
      address: json['address'] as String?,
      gender: json['gender'] as String?,
      mobile: json['mobile'] != null
          ? PhoneNumber.dirty(json['mobile'] as String)
          : null,
      isAdmin: json['is_admin'] as bool? ?? false,
    );
  }

  /// Converts the UserModel instance to a Firestore document.
  Map<String, dynamic> toFirestore() {
    return {
      'email': email?.value ?? '',
      'full_name': fullName,
      'photo': photo,
      'address': address,
      'gender': gender,
      'mobile': mobile?.value ?? '',
      'is_admin': isAdmin, // Include the isAdmin field
    };
  }

  /// Converts the UserModel instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'email': email?.value ?? '',
      'full_name': fullName,
      'photo': photo,
      'address': address,
      'gender': gender,
      'mobile': mobile?.value ?? '',
      'id': id,
      'is_admin': isAdmin,
    };
  }

  /// Returns a copy of the UserModel instance with the specified fields replaced with new values.
  UserModel copyWith({
    String? id,
    Email? email,
    String? fullName,
    String? photo,
    String? address,
    String? gender,
    PhoneNumber? mobile,
    Password? confirmPassword,
    Password? password,
    bool? isAdmin,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      photo: photo ?? this.photo,
      address: address ?? this.address,
      gender: gender ?? this.gender,
      mobile: mobile ?? this.mobile,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      password: password ?? this.password,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }

  /// Returns a copy of the UserModel instance with a specific field replaced with a new value.
  UserModel copyWithField(String field, dynamic value) {
    switch (field) {
      case 'email':
        final email = Email.dirty(value);
        return copyWith(email: email);
      case 'fullName':
        return copyWith(fullName: value);
      case 'photo':
        return copyWith(photo: value);
      case 'address':
        return copyWith(address: value);
      case 'gender':
        return copyWith(gender: value);
      case 'mobile':
        final mobile = PhoneNumber.dirty(value);
        return copyWith(mobile: mobile);
      case 'password':
        final password = Password.dirty(value);
        return copyWith(password: password);
      case 'confirmPassword':
        final confirmPassword = Password.dirty(value);
        return copyWith(confirmPassword: confirmPassword);
      case 'isAdmin':
        return copyWith(isAdmin: value);
      default:
        return this;
    }
  }

  // Check form validity
  bool get isValid {
    return email?.displayError == null && password?.displayError == null;
  }

  @override
  List<Object?> get props => [
        email,
        id,
        fullName,
        photo,
        address,
        gender,
        mobile,
        password,
        confirmPassword,
        isAdmin,
      ];
}
