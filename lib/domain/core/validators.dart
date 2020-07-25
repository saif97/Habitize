import 'package:dartz/dartz.dart';
import 'package:validators/validators.dart';

import 'enums.dart';

Either<EnumFailureValueObj, String> validateUrl(String input) {
  if (isURL(input)) {
    return right(input);
  } else {
    return left(EnumFailureValueObj.invalidUrl);
  }
}
