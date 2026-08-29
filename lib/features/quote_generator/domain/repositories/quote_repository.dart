import '../entities/quote.dart';

/// Abstract Domain Repository interface defining data contracts for Quote feature.
/// Follows Dependency Inversion Principle (DIP).
abstract class QuoteRepository {
  /// Fetches a random quote from the configured data sources.
  Future<Quote> getRandomQuote();
}
