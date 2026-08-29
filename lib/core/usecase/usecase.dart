import 'package:equatable/equatable.dart';

/// Abstract UseCase interface establishing contract for all domain use cases.
/// [Type] represents return value type wrapped in Dart's Record/Either or Future.
/// [Params] represents input parameters needed to execute the use case.
abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}

/// Helper class when a UseCase does not require any input parameters.
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
