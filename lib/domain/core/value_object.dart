import 'package:dartz/dartz.dart';

import 'errors.dart';

abstract class ValueObject<F, T> {
  const ValueObject();
  Either<F, T> get value;

  T getOrCrash() => value.fold((f) => throw UnexpectedValueError(f), id);

  bool isValid() => value.isRight();

  String ValidationMessage() {
    return value.fold(
      (e) {
        throw UnimplementedError();
      },
      (_) => null,
    );
  }

  @override
  String toString() => 'Value($value)';
}
