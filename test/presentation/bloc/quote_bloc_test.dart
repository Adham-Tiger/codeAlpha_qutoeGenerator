import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:random_quote_generaetor/core/usecase/usecase.dart';
import 'package:random_quote_generaetor/features/quote_generator/domain/entities/quote.dart';
import 'package:random_quote_generaetor/features/quote_generator/domain/usecases/get_random_quote.dart';
import 'package:random_quote_generaetor/features/quote_generator/presentation/bloc/quote_bloc.dart';
import 'package:random_quote_generaetor/features/quote_generator/presentation/bloc/quote_event.dart';
import 'package:random_quote_generaetor/features/quote_generator/presentation/bloc/quote_state.dart';

class MockGetRandomQuote extends Mock implements GetRandomQuote {}

void main() {
  late QuoteBloc bloc;
  late MockGetRandomQuote mockGetRandomQuote;

  setUp(() {
    registerFallbackValue(NoParams());
    mockGetRandomQuote = MockGetRandomQuote();
    bloc = QuoteBloc(getRandomQuoteUseCase: mockGetRandomQuote);
  });

  const tQuote = Quote(
    id: '1',
    text: 'Stay Hungry, Stay Foolish',
    author: 'Steve Jobs',
    category: 'Inspiration',
  );

  test('initial state should be QuoteInitial', () {
    expect(bloc.state, equals(const QuoteInitial()));
  });

  blocTest<QuoteBloc, QuoteState>(
    'should emit [QuoteLoading, QuoteLoaded] when quote is fetched successfully',
    build: () {
      when(() => mockGetRandomQuote(any())).thenAnswer((_) async => tQuote);
      return bloc;
    },
    act: (bloc) => bloc.add(const FetchRandomQuoteEvent()),
    expect: () => [
      const QuoteLoading(),
      const QuoteLoaded(quote: tQuote),
    ],
    verify: (_) {
      verify(() => mockGetRandomQuote(any())).called(1);
    },
  );

  blocTest<QuoteBloc, QuoteState>(
    'should emit [QuoteLoading, QuoteError] when quote fetching fails',
    build: () {
      when(() => mockGetRandomQuote(any())).thenThrow(Exception('Failed to load'));
      return bloc;
    },
    act: (bloc) => bloc.add(const FetchRandomQuoteEvent()),
    expect: () => [
      const QuoteLoading(),
      const QuoteError(message: 'Failed to load'),
    ],
  );
}
