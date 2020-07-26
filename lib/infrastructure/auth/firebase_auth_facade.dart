import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../domain/auth/i_auth_facade.dart';
import '../../domain/auth/user.dart';
import '../../domain/auth/value_objects.dart';
import '../../domain/core/enums.dart';
import '../core/utils_firestore.dart';

class FirebaseAuthFacade implements IAuthFacade {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  FirebaseAuthFacade(this._firebaseAuth, this._googleSignIn);

  @override
  Future<Option<User>> getSignedInUser() =>
      _firebaseAuth.currentUser().then((fbUser) => optionOf(fbUser?.toDomain()));

  @override
  Future<Either<EnumFailureAuth, Unit>> registerWithEmailAndPassword(
      {EmailAddress emailAddress, Password password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: emailAddress.getOrCrash(),
        password: password.getOrCrash(),
      );
      return right(unit);
    } on PlatformException catch (e) {
      if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
        return left(EnumFailureAuth.emailAlreadyInUse);
      } else {
        return left(EnumFailureAuth.serverError);
      }
    }
  }

  @override
  Future<Either<EnumFailureAuth, Unit>> signInWithEmailAndPassword(
      {EmailAddress emailAddress, Password password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: emailAddress.getOrCrash(),
        password: password.getOrCrash(),
      );

      return right(unit);
    } on PlatformException catch (e) {
      if (e.code == 'ERROR_WRONG_PASSWORD' || e.code == 'ERROR_USER_NOT_FOUND') {
        return left(EnumFailureAuth.emailAlreadyInUse);
      } else {
        return left(EnumFailureAuth.serverError);
      }
    }
  }

  @override
  Future<Either<EnumFailureAuth, Unit>> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return left(EnumFailureAuth.cancelledByUser);
      }

      final googleAuthentication = await googleUser.authentication;

      final authCredential = GoogleAuthProvider.getCredential(
        idToken: googleAuthentication.idToken,
        accessToken: googleAuthentication.accessToken,
      );

      await _firebaseAuth.signInWithCredential(authCredential);
      return right(unit);
    } on PlatformException catch (_) {
      return left(EnumFailureAuth.serverError);
    }
  }

  @override
  Future<void> signOut() => Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
}
