import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_theme.dart';
import 'features/quote_generator/data/datasources/quote_remote_data_source.dart';
import 'features/quote_generator/data/repositories/quote_repository_impl.dart';
import 'features/quote_generator/domain/usecases/get_random_quote.dart';
import 'features/quote_generator/presentation/bloc/quote_bloc.dart';
import 'features/quote_generator/presentation/screens/quote_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Dependency Injection (DIP Principle)
  // Remote Data Source connecting to AdviceSlip API (https://api.adviceslip.com/advice)
  final remoteDataSource = QuoteRemoteDataSourceImpl();
  final repository = QuoteRepositoryImpl(remoteDataSource: remoteDataSource);

  // Domain Layer instantiation
  final getRandomQuoteUseCase = GetRandomQuote(repository);

  runApp(RandomQuoteApp(getRandomQuoteUseCase: getRandomQuoteUseCase));
}

/// Root Application Widget configuring theme and top-level BLoC Providers.
class RandomQuoteApp extends StatelessWidget {
  final GetRandomQuote getRandomQuoteUseCase;

  const RandomQuoteApp({
    super.key,
    required this.getRandomQuoteUseCase,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuoteBloc(getRandomQuoteUseCase: getRandomQuoteUseCase),
      child: MaterialApp(
        title: 'Random Quote Generator',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const QuoteScreen(),
      ),
    );
  }
}
