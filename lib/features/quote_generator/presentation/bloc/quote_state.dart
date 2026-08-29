import 'package:equatable/equatable.dart';
import '../../domain/entities/quote.dart';

/// Abstract base state class for Quote BLoC.
abstract class QuoteState extends Equatable {
  const QuoteState();

  @override
  List<Object?> get props => [];
}

/// Initial uninitialized state.
class QuoteInitial extends QuoteState {
  const QuoteInitial();
}

/// Emitted while fetching a new quote.
class QuoteLoading extends QuoteState {
  const QuoteLoading();
}

/// Emitted when quote fetching succeeds.
class QuoteLoaded extends QuoteState {
  final Quote quote;

  const QuoteLoaded({required this.quote});

  @override
  List<Object?> get props => [quote];
}

/// Emitted when an error occurs during quote retrieval.
class QuoteError extends QuoteState {
  final String message;

  const QuoteError({required this.message});

  @override
  List<Object?> get props => [message];
}
