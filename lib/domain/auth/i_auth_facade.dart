import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../core/enums.dart';
import 'user.dart';
import 'value_objects.dart';

abstract class IAuthFacade {
  Future<Option<User>> getSignedInUser();
  Future<Either<EnumFailureAuth, Unit>> registerWithEmailAndPassword({
    @required EmailAddress emailAddress,
    @required Password password,
  });
  Future<Either<EnumFailureAuth, Unit>> signInWithEmailAndPassword({
    @required EmailAddress emailAddress,
    @required Password password,
  });
  Future<Either<EnumFailureAuth, Unit>> signInWithGoogle();
  Future<void> signOut();
}
