import 'package:equatable/equatable.dart';

/// Base class for handling domain-level failures across the application.
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

/// Represents failure originating from local data cache/storage.
class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Failed to load quote from local storage.']);
}

/// Represents failure originating from network or remote server.
class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Failed to fetch quote from remote server.']);
}

/// Represents generic/unexpected application failures.
class UnexpectedFailure extends Failure {
  const UnexpectedFailure([super.message = 'An unexpected error occurred.']);
}
