sealed class Failure {
  const Failure(this.message);
  final String message;
}

class PermissionFailure extends Failure {
  const PermissionFailure(super.message);
}

class ServiceFailure extends Failure {
  const ServiceFailure(super.message);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}
