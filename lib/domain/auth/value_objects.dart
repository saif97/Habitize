import 'package:dartz/dartz.dart';

import '../core/enums.dart';
import '../core/parent_value_object.dart';
import 'validators.dart';

class EmailAddress extends ValueObject<EnumFailureValueObj, String> {
  @override
  final Either<EnumFailureValueObj, String> value;

  factory EmailAddress(String input) {
    assert(input != null);
    return EmailAddress._(
      validateEmailAddress(input),
    );
  }

  const EmailAddress._(this.value);
}

class Password extends ValueObject<EnumFailureValueObj, String> {
  @override
  final Either<EnumFailureValueObj, String> value;

  factory Password(String input) {
    assert(input != null);
    return Password._(
      validatePassword(input),
    );
  }

  const Password._(this.value);
}
