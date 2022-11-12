import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:cache/cache.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
// import 'package:firebase_auth_desktop/firebase_auth_desktop.dart'
//     as firebase_auth_desktop;
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

/// {@template authentication_repository}
/// Repository which manages user authentication.
class AuthenticationRepository {
  /// {@macro authentication_repository}
  AuthenticationRepository({
    CacheClient? cache,
    firebase_auth.FirebaseAuth? firebaseAuth,
    // firebase_auth_desktop.FirebaseAuthDesktop? firebaseAuthDesktop,
    GoogleSignIn? googleSignIn,
  })  : _cache = cache ?? CacheClient(),
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        // _firebaseAuthDesktop = firebaseAuthDesktop ??
        //     firebase_auth_desktop.FirebaseAuthDesktop.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  final CacheClient _cache;
  final firebase_auth.FirebaseAuth _firebaseAuth;

  // final firebase_auth_desktop.FirebaseAuthDesktop? _firebaseAuthDesktop;
  final GoogleSignIn _googleSignIn;

  /// Whether or not the current environment is web
  /// Should only be overriden for testing purposes. Otherwise,
  /// defaults to [kIsWeb]
  @visibleForTesting
  bool isWeb = kIsWeb;

  /// Whether or not the current environment is Apple device (iOS, MacOS)
  /// Should only be overriden for testing purposes. Otherwise,
  /// defaults to [TargetPlatform.iOS] and [TargetPlatform.macOS]
  bool isApple = defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.macOS;

  /// Whether or not the current environment is Desktop (Windows, Linux)
  /// Should only be overriden for testing purposes. Otherwise,
  /// defaults to [TargetPlatform.windows] and [TargetPlatform.linux]
  bool isDesktop = defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.linux;

  /// User cache key.
  /// Should only be used for testing purposes.
  @visibleForTesting
  static const userCacheKey = '__user_cache_key__';

  /// Stream of [FirebaseUserModel] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [FirebaseUserModel.empty] if the user is not authenticated.
  Stream<FirebaseUserModel?> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user =
          firebaseUser == null ? FirebaseUserModel.empty : firebaseUser.toUser;
      _cache.write(key: userCacheKey, value: user);
      return user;
    });
  }

  /// Returns the current cached user.
  /// Defaults to [FirebaseUserModel.empty] if there is no cached user.
  FirebaseUserModel get currentUser {
    return _cache.read<FirebaseUserModel>(key: userCacheKey) ??
        FirebaseUserModel.empty;
  }

  /// Creates a new user with the provided [email] and [password].
  ///
  /// Throws a [SignUpWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> signUp({required String email, required String password}) async {
    try {
      if (isDesktop) {
        // await _firebaseAuthDesktop!
        //     .createUserWithEmailAndPassword(email, password);
      } else {
        await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      }
    } on FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  /// Starts the Sign In with Google Flow.
  ///
  /// Throws a [LogInWithGoogleFailure] if an exception occurs.
  Future<void> logInWithGoogle() async {
    try {
      late final firebase_auth.AuthCredential credential;
      if (isWeb || isDesktop) {
        final googleProvider = firebase_auth.GoogleAuthProvider();
        if (isDesktop) {
          // final userCredentialPlatform =
          //     await _firebaseAuthDesktop!.signInWithPopup(googleProvider);
          // userCredentialPlatform.credential!;
        } else {
          final userCredential = await _firebaseAuth.signInWithPopup(
            googleProvider,
          );
          credential = userCredential.credential!;
        }
      } else {
        final googleUser = await _googleSignIn.signIn();
        final googleAuth = await googleUser!.authentication;
        credential = firebase_auth.GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await _firebaseAuth.signInWithCredential(credential);
      }
    } on FirebaseAuthException catch (e) {
      throw LogInWithGoogleFailure.fromCode(e.code);
    } catch (e) {
      throw const LogInWithGoogleFailure();
    }
  }

  /// Starts the Sign In with Google Flow.
  ///
  /// Throws a [SignInWithAppleFailure] if an exception occurs.

  Future<void> logInWithApple() async {
    /// Before you begin configure Sign In with Apple and enable Apple
    /// as a sign-in provider.
    ///
    /// Next, make sure that your Runner apps have
    /// the "Sign in with Apple" capability.

    /// Generates a cryptographically secure random nonce, to be included in a
    /// credential request.
    String generateNonce([int length = 32]) {
      // ignore: lines_longer_than_80_chars
      const charset =
          '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
      final random = Random.secure();
      // ignore: lines_longer_than_80_chars
      return List.generate(
          length, (_) => charset[random.nextInt(charset.length)]).join();
    }

    /// Returns the sha256 hash of [input] in hex notation.
    String sha256ofString(String input) {
      final bytes = utf8.encode(input);
      final digest = sha256.convert(bytes);
      return digest.toString();
    }

    if (isApple) {
      late final firebase_auth.AuthCredential oauthCredential;

      /// To prevent replay attacks with the credential returned from Apple,
      /// we include a nonce in the credential request. When signing in with
      /// Firebase, the nonce in the id token returned by Apple, is expected
      /// to match the sha256 hash of `rawNonce`.
      ///
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);

      /// Request credential for the currently signed in Apple account.
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      /// Create an `OAuthCredential` from the credential returned by Apple.
      oauthCredential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      /// Sign in the user with Firebase. If the nonce we generated earlier
      /// does not match the nonce in `appleCredential.identityToken`,
      /// sign in will fail.
      await _firebaseAuth.signInWithCredential(oauthCredential);
    } else if (isWeb) {
      /// Create and configure an OAuthProvider for Sign In with Apple.
      final provider = OAuthProvider('apple.com')
        ..addScope('email')
        ..addScope('name');

      /// Sign in the user with Firebase.
      if (isDesktop) {
        // await _firebaseAuthDesktop!.signInWithPopup(provider);
      } else {
        await _firebaseAuth.signInWithPopup(provider);
      }
    }
  }

  /// Signs in with the provided [email] and [password].
  ///
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      if (isDesktop) {
        // await _firebaseAuthDesktop!.
        // signInWithEmailAndPassword(email, password);
      } else {
        await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      }
    } on FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  // /// Signs in with the provided [email] and [password].
  // ///
  // /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  // Future<void> logInWithPhone({
  //   required String email,
  //   required String password,
  // }) async {
  //   try {
  //     await _firebaseAuth.signInWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
  //   } catch (_) {
  //     throw const LogInWithEmailAndPasswordFailure();
  //   }
  // }

  /// Signs out the current user which will emit
  /// [FirebaseUserModel.empty] from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut() async {
    try {
      await Future.wait([
        // if (isDesktop)
        //   _firebaseAuthDesktop!.signOut()
        // else
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (_) {
      throw LogOutFailure();
    }
  }
}

extension on firebase_auth.User {
  FirebaseUserModel get toUser {
    return FirebaseUserModel(
        id: uid, email: email, name: displayName, photo: photoURL);
  }
}

// extension on UserPlatform {
//   FirebaseUserModel get toUser {
//     return FirebaseUserModel(
//         id: uid, email: email, name: displayName, photo: photoURL);
//   }
// }

/// {@template sign_up_with_email_and_password_failure}
/// Thrown if during the sign up process if a failure occurs.
class SignUpWithEmailAndPasswordFailure implements Exception {
  /// {@macro sign_up_with_email_and_password_failure}
  const SignUpWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// The associated error message.
  /// Create an authentication message
  /// from a firebase authentication exception code.
  /// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/createUserWithEmailAndPassword.html
  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
          'An account already exists for that email.',
        );
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
          'Please enter a stronger password.',
        );
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }

  /// The associated error message.
  final String message;
}

/// {@template log_in_with_email_and_password_failure}
/// Thrown during the login process if a failure occurs.
/// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInWithEmailAndPassword.html
class LogInWithEmailAndPasswordFailure implements Exception {
  /// {@macro log_in_with_email_and_password_failure}
  const LogInWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LogInWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const LogInWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LogInWithEmailAndPasswordFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LogInWithEmailAndPasswordFailure(
          'Incorrect password, please try again.',
        );
      default:
        return const LogInWithEmailAndPasswordFailure();
    }
  }

  /// The associated error message.
  final String message;
}

/// {@template log_in_with_google_failure}
/// Thrown during the sign in with google process if a failure occurs.
/// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInWithCredential.html
class LogInWithGoogleFailure implements Exception {
  /// {@macro log_in_with_google_failure}
  const LogInWithGoogleFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory LogInWithGoogleFailure.fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return const LogInWithGoogleFailure(
          'Account exists with different credentials.',
        );
      case 'invalid-credential':
        return const LogInWithGoogleFailure(
          'The credential received is malformed or has expired.',
        );
      case 'operation-not-allowed':
        return const LogInWithGoogleFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'user-disabled':
        return const LogInWithGoogleFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LogInWithGoogleFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LogInWithGoogleFailure(
          'Incorrect password, please try again.',
        );
      case 'invalid-verification-code':
        return const LogInWithGoogleFailure(
          'The credential verification code received is invalid.',
        );
      case 'invalid-verification-id':
        return const LogInWithGoogleFailure(
          'The credential verification ID received is invalid.',
        );
      default:
        return const LogInWithGoogleFailure();
    }
  }

  /// The associated error message.
  final String message;
}

/// Thrown during the sign in with google process if a failure occurs.
class SignInWithAppleFailure implements Exception {}

/// Thrown during the logout process if a failure occurs.
class LogOutFailure implements Exception {}
