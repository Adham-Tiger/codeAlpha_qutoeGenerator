import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/quote.dart';
import '../../domain/repositories/quote_repository.dart';
import '../datasources/quote_remote_data_source.dart';

/// Concrete implementation of [QuoteRepository] domain interface.
/// Fetches quotes directly from AdviceSlip REST API (https://api.adviceslip.com/advice).
class QuoteRepositoryImpl implements QuoteRepository {
  final QuoteRemoteDataSource remoteDataSource;

  QuoteRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Quote> getRandomQuote() async {
    try {
      final remoteQuoteModel = await remoteDataSource.getRandomQuote();
      return remoteQuoteModel;
    } on ServerException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Failed to fetch quote from AdviceSlip API.');
    }
  }
}
