import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:random_quote_generaetor/core/usecase/usecase.dart';
import 'package:random_quote_generaetor/features/quote_generator/domain/entities/quote.dart';
import 'package:random_quote_generaetor/features/quote_generator/domain/repositories/quote_repository.dart';
import 'package:random_quote_generaetor/features/quote_generator/domain/usecases/get_random_quote.dart';

class MockQuoteRepository extends Mock implements QuoteRepository {}

void main() {
  late GetRandomQuote usecase;
  late MockQuoteRepository mockQuoteRepository;

  setUp(() {
    mockQuoteRepository = MockQuoteRepository();
    usecase = GetRandomQuote(mockQuoteRepository);
  });

  const tQuote = Quote(
    id: '1',
    text: 'Test Quote Text',
    author: 'Test Author',
    category: 'Testing',
  );

  test('should get random quote from the repository', () async {
    // Arrange
    when(() => mockQuoteRepository.getRandomQuote())
        .thenAnswer((_) async => tQuote);

    // Act
    final result = await usecase(NoParams());

    // Assert
    expect(result, equals(tQuote));
    verify(() => mockQuoteRepository.getRandomQuote()).called(1);
    verifyNoMoreInteractions(mockQuoteRepository);
  });
}
