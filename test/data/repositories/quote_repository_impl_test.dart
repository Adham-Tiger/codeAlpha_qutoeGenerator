import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:random_quote_generaetor/core/errors/exceptions.dart';
import 'package:random_quote_generaetor/features/quote_generator/data/datasources/quote_remote_data_source.dart';
import 'package:random_quote_generaetor/features/quote_generator/data/models/quote_model.dart';
import 'package:random_quote_generaetor/features/quote_generator/data/repositories/quote_repository_impl.dart';

class MockQuoteRemoteDataSource extends Mock implements QuoteRemoteDataSource {}

void main() {
  late QuoteRepositoryImpl repository;
  late MockQuoteRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockQuoteRemoteDataSource();
    repository = QuoteRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  const tQuoteModel = QuoteModel(
    id: '120',
    text: 'A nod is as good as a wink to a blind horse.',
    author: 'Wisdom',
    category: 'Advice',
  );

  group('getRandomQuote', () {
    test('should return QuoteModel from remote AdviceSlip API when call is successful', () async {
      // Arrange
      when(() => mockRemoteDataSource.getRandomQuote())
          .thenAnswer((_) async => tQuoteModel);

      // Act
      final result = await repository.getRandomQuote();

      // Assert
      expect(result, equals(tQuoteModel));
      verify(() => mockRemoteDataSource.getRandomQuote()).called(1);
    });

    test('should rethrow Exception when remote API call fails with ServerException', () async {
      // Arrange
      when(() => mockRemoteDataSource.getRandomQuote())
          .thenThrow(const ServerException('Server Error'));

      // Act & Assert
      expect(() => repository.getRandomQuote(), throwsA(isA<Exception>()));
      verify(() => mockRemoteDataSource.getRandomQuote()).called(1);
    });
  });
}
