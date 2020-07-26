import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/auth/i_auth_facade.dart';
import '../../domain/auth/user.dart';
import '../../domain/core/errors.dart';
import '../../domain/core/value_objects.dart';
import '../../locator.dart';

extension XFirestore on Firestore {
  Future<DocumentReference> userDoc() async {
    final optionUser = await locator<IAuthFacade>().getSignedInUser();
    final user = optionUser.getOrElse(() => throw NotAuthenticatedError());
    return Firestore.instance.collection('users').document(user.id.getOrCrash());
  }
}

extension XDocReference on DocumentReference {
  CollectionReference get habitCollection => collection('habits');
}

extension XFBUser on FirebaseUser {
  User toDomain() => User(id: UniqueId.FromUniqueString(uid));
}
