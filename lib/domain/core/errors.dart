class NotAuthenticatedError extends Error {}

class UnexpectedValueError<F> extends Error {
  final F _failureType;

  UnexpectedValueError(this._failureType);
  @override
  String toString() => "Unexpected Error of type $_failureType. This value should NOT be there.";
}

