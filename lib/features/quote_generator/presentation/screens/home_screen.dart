import 'package:flutter/material.dart';
import 'quote_screen.dart';

/// Legacy HomeScreen wrapper delegating to [QuoteScreen].
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const QuoteScreen();
  }
}