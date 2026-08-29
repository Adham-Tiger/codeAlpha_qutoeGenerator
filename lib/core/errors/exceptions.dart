/// Exception thrown when local data source encounters an error.
class CacheException implements Exception {
  final String message;
  const CacheException([this.message = 'Cache operation failed.']);
}

/// Exception thrown when remote network call encounters an error.
class ServerException implements Exception {
  final String message;
  const ServerException([this.message = 'Server request failed.']);
}
