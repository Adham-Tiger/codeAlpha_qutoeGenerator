import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/quote_bloc.dart';
import '../bloc/quote_event.dart';
import '../bloc/quote_state.dart';
import '../widgets/quote_actions.dart';
import '../widgets/quote_card.dart';

/// Primary UI View for Random Quote Generator.
/// Pure View listening to [QuoteState] changes and dispatching [QuoteEvent]s.
class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  @override
  void initState() {
    super.initState();
    // Requirement 1: Automatically fetch a random quote when app opens
    context.read<QuoteBloc>().add(const FetchRandomQuoteEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0F0C20),
              Color(0xFF1F1C2C),
              Color(0xFF2D1F3D),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              children: [
                // Minimal Header
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6C5CE7).withAlpha(40),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.auto_awesome,
                        color: Color(0xFF6C5CE7),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'DAILY INSPIRATION',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2.0,
                        color: Colors.white60,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                
                // Quote Display Content Area
                Expanded(
                  child: Center(
                    child: BlocBuilder<QuoteBloc, QuoteState>(
                      builder: (context, state) {
                        if (state is QuoteLoading || state is QuoteInitial) {
                          return const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                color: Color(0xFF6C5CE7),
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Inspiring your mind...',
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          );
                        } else if (state is QuoteLoaded) {
                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 400),
                            transitionBuilder: (child, animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: ScaleTransition(
                                  scale: Tween<double>(begin: 0.95, end: 1.0)
                                      .animate(animation),
                                  child: child,
                                ),
                              );
                            },
                            child: QuoteCard(
                              key: ValueKey(state.quote.id),
                              quote: state.quote,
                            ),
                          );
                        } else if (state is QuoteError) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.error_outline_rounded,
                                color: Colors.redAccent,
                                size: 48,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                state.message,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ),
                
                // Bottom Actions Section
                BlocBuilder<QuoteBloc, QuoteState>(
                  builder: (context, state) {
                    final currentQuote = state is QuoteLoaded ? state.quote : null;
                    final isLoading = state is QuoteLoading;

                    return QuoteActions(
                      onFetchNewQuote: () {
                        context.read<QuoteBloc>().add(const FetchRandomQuoteEvent());
                      },
                      currentQuote: currentQuote,
                      isLoading: isLoading,
                    );
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
