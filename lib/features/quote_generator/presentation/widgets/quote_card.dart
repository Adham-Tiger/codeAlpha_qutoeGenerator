import 'package:flutter/material.dart';
import '../../domain/entities/quote.dart';

/// Reusable UI Widget rendering the Quote details with high visual polish.
class QuoteCard extends StatelessWidget {
  final Quote quote;

  const QuoteCard({
    super.key,
    required this.quote,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        color: const Color(0x1FFFFFFF), // Glassmorphism background tint
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0x33FFFFFF),
          width: 1.5,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x2B000000),
            blurRadius: 30,
            spreadRadius: 2,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category Tag
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withAlpha(50),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: theme.colorScheme.primary.withAlpha(100),
                width: 1,
              ),
            ),
            child: Text(
              quote.category.toUpperCase(),
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Opening Quote Icon
          Icon(
            Icons.format_quote_rounded,
            size: 40,
            color: theme.colorScheme.primary.withAlpha(180),
          ),
          const SizedBox(height: 8),
          // Quote Text
          Text(
            '"${quote.text}"',
            style: theme.textTheme.displaySmall?.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              height: 1.4,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          // Author Divider & Name
          Row(
            children: [
              Container(
                width: 32,
                height: 2,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  quote.author,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.white70,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
