import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:random_quote_generaetor/core/usecase/usecase.dart';
import 'package:random_quote_generaetor/features/quote_generator/domain/entities/quote.dart';
import 'package:random_quote_generaetor/features/quote_generator/domain/usecases/get_random_quote.dart';
import 'package:random_quote_generaetor/main.dart';

class MockGetRandomQuote extends Mock implements GetRandomQuote {}

void main() {
  late MockGetRandomQuote mockGetRandomQuote;

  setUp(() {
    registerFallbackValue(NoParams());
    mockGetRandomQuote = MockGetRandomQuote();
  });

  const tQuote = Quote(
    id: '1',
    text: 'Test Widget Quote',
    author: 'Test Author',
    category: 'WidgetTest',
  );

  testWidgets('RandomQuoteApp renders QuoteScreen and fetches quote', (WidgetTester tester) async {
    when(() => mockGetRandomQuote(any())).thenAnswer((_) async => tQuote);

    await tester.pumpWidget(RandomQuoteApp(getRandomQuoteUseCase: mockGetRandomQuote));
    await tester.pump(); // Trigger build

    expect(find.text('DAILY INSPIRATION'), findsOneWidget);
  });
}
