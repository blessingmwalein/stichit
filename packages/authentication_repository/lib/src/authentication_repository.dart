import 'dart:async';
import 'dart:convert';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:cache/cache.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

/// {@template authentication_repository}
/// Repository which manages user authentication.
/// {@endtemplate}
class AuthenticationRepository {
  /// {@macro authentication_repository}
  AuthenticationRepository({
    CacheClient? cache,
    firebase_auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
    FlutterSecureStorage? storage,
  })  : _cache = cache ?? CacheClient(),
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard(),
        _storage = storage ?? const FlutterSecureStorage();

  final CacheClient _cache;
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FlutterSecureStorage _storage;

  /// Whether or not the current environment is web
  /// Should only be overridden for testing purposes. Otherwise,
  /// defaults to [kIsWeb]
  @visibleForTesting
  bool isWeb = kIsWeb;

  /// UserModel cache key.
  /// Should only be used for testing purposes.
  @visibleForTesting
  static const userCacheKey = '__user_cache_key__';

  @visibleForTesting
  static const barberDetailsCacheKey = '__barber_details_cache_key__';

  /// Stream of [UserModel] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [UserModel.empty] if the user is not authenticated.
  Stream<UserModel> get user {
    return _firebaseAuth.authStateChanges().asyncMap((firebaseUser) async {
      if (firebaseUser == null) {
        _cache.write(key: userCacheKey, value: UserModel.empty);
        return UserModel.empty;
      }

      UserModel? userDoc = await getUserByEmail(firebaseUser.email ?? '');
      if (userDoc == null) {
        _cache.write(key: userCacheKey, value: UserModel.empty);
        return UserModel.empty;
      }
      _cache.write(key: userCacheKey, value: jsonEncode(userDoc.toJson()));
      return userDoc;
    });
  }

  /// Returns the current cached user.
  /// Defaults to [UserModel.empty] if there is no cached user.
  Future<UserModel> get currentUser async {
    final userJson = await _storage.read(key: userCacheKey);

    if (userJson == null) {
      return UserModel.empty;
    }

    final decodedJson = jsonDecode(userJson);

    if (decodedJson is Map<String, dynamic>) {
      return UserModel.fromJson(decodedJson);
    }

    return UserModel.empty;
  }

  /// Signs out the current user which will emit
  /// [UserModel.empty] from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (_) {
      throw LogOutFailure();
    }
  }

  Future<void> logInWithGoogle() async {
    try {
      late final firebase_auth.AuthCredential credential;
      if (isWeb) {
        final googleProvider = firebase_auth.GoogleAuthProvider();
        final userCredential =
            await _firebaseAuth.signInWithPopup(googleProvider);
        credential = userCredential.credential!;
      } else {
        final googleUser = await _googleSignIn.signIn();
        final googleAuth = await googleUser!.authentication;
        credential = firebase_auth.GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
      }

      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      // Check if the user exists in Firestore
      final userDoc = await _firestore
          .collection('users')
          .where('email', isEqualTo: credential)
          .get();
      print('userDoc: ${userDoc.docs.first}');
      if (userDoc.docs.isEmpty) {
        // Sign out the user from Google Authentication
        await _googleSignIn.signOut();
        await _firebaseAuth.signOut();
        throw LogInWithGoogleFailure.fromCode('user-not-found');
      }
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithGoogleFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithGoogleFailure();
    }
  }

  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      //get user by email and set flutter secure storage

      UserModel? user = await getUserByEmail(email);
      if (user != null) {
        await _storage.write(
          key: userCacheKey,
          value: jsonEncode(user.toJson()),
        );
      }
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  //get user by email
  Future<UserModel?> getUserByEmail(String email) async {
    try {
      final userDoc = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();
      if (userDoc.docs.isEmpty) {
        return null;
      }
      return UserModel.fromFirestore(userDoc.docs.first);
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<bool> signUp({
    UserModel? user,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: user?.email?.value ?? "",
        password: user?.password?.value ?? "",
      );

      //create user
      await createUser(user!);
      //login user
      await logInWithEmailAndPassword(
        email: user.email?.value ?? "",
        password: user.password?.value ?? "",
      );

      return true;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (error) {
      throw SignUpWithEmailAndPasswordFailure(error.toString());
    }
  }

  //create user
  Future<void> createUser(UserModel user) async {
    try {
      await _firestore.collection('users').add(user.toFirestore());
    } catch (e) {
      print('Error: $e');
    }
  }
}

extension on firebase_auth.User {
  /// Maps a [firebase_auth.UserModel] into a [UserModel].
  UserModel get toUser {
    return UserModel(
        id: uid,
        email: Email.dirty(email ?? ''),
        fullName: displayName,
        photo: photoURL);
  }
}
