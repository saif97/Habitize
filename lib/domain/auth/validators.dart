import 'package:dartz/dartz.dart';

import '../core/enums.dart';

Either<EnumFailureValueObj, String> validateEmailAddress(String input) {
  const emailRegex = r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
  if (RegExp(emailRegex).hasMatch(input)) {
    return right(input);
  } else {
    return left(EnumFailureValueObj.invalidEmail);
  }
}

Either<EnumFailureValueObj, String> validatePassword(String input) {
  if (input.length >= 6) {
    return right(input);
  } else {
    return left(EnumFailureValueObj.ShortPassword);
  }
}

Either<EnumFailureValueObj, String> validateEmpty(String input) {
  if (input.trim().isNotEmpty) {
    return right(input);
  } else {
    return left(EnumFailureValueObj.empty);
  }
}
