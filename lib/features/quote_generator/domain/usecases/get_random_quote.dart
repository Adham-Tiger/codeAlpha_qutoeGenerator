import '../../../../core/usecase/usecase.dart';
import '../entities/quote.dart';
import '../repositories/quote_repository.dart';

/// Single-responsibility use case that retrieves a random quote.
class GetRandomQuote implements UseCase<Quote, NoParams> {
  final QuoteRepository repository;

  GetRandomQuote(this.repository);

  @override
  Future<Quote> call(NoParams params) async {
    return await repository.getRandomQuote();
  }
}
