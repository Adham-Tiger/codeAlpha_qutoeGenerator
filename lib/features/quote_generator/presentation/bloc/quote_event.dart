import 'package:equatable/equatable.dart';

/// Abstract base event class for Quote BLoC.
abstract class QuoteEvent extends Equatable {
  const QuoteEvent();

  @override
  List<Object?> get props => [];
}

/// Triggered on app load or when user taps "New Quote" button.
class FetchRandomQuoteEvent extends QuoteEvent {
  const FetchRandomQuoteEvent();
}
