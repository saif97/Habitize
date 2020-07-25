import 'package:dartz/dartz.dart';

import '../auth/validators.dart';
import 'enums.dart';
import 'parent_value_object.dart';
import 'validators.dart';

class UniqueId extends ValueObject<EnumFailureValueObj, String> {
  @override
  final Either<EnumFailureValueObj, String> value;

  factory UniqueId(String input) {
    assert(input != null);
    return UniqueId._(validateEmpty(input));
  }

  const UniqueId._(this.value);
}

class Name extends ValueObject<EnumFailureValueObj, String> {
  @override
  final Either<EnumFailureValueObj, String> value;

  factory Name(String input) {
    assert(input != null);
    return Name._(
      validateEmpty(input),
    );
  }

  const Name._(this.value);
}

class Url extends ValueObject<EnumFailureValueObj, String> {
  const Url._(this.value);
  @override
  final Either<EnumFailureValueObj, String> value;

  factory Url(String input) {
    assert(input != null);
    return Url._(
      validateUrl(input),
    );
  }

  String getOrDefaultToEmptyString() => value.fold((_) => '', (v) => v);
}
