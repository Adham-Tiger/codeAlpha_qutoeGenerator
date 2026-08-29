import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/usecases/get_random_quote.dart';
import 'quote_event.dart';
import 'quote_state.dart';

/// Presentation Business Logic Component (BLoC) managing quote state logic.
/// Completely decoupled from UI rendering elements.
class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  final GetRandomQuote getRandomQuoteUseCase;

  QuoteBloc({required this.getRandomQuoteUseCase}) : super(const QuoteInitial()) {
    on<FetchRandomQuoteEvent>(_onFetchRandomQuote);
  }

  Future<void> _onFetchRandomQuote(
    FetchRandomQuoteEvent event,
    Emitter<QuoteState> emit,
  ) async {
    emit(const QuoteLoading());
    try {
      final quote = await getRandomQuoteUseCase(NoParams());
      emit(QuoteLoaded(quote: quote));
    } catch (e) {
      emit(QuoteError(message: e.toString().replaceAll('Exception: ', '')));
    }
  }
}
