import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../domain/entities/quote.dart';

/// Action controls for generating new quotes, copying to clipboard, and sharing.
class QuoteActions extends StatelessWidget {
  final VoidCallback onFetchNewQuote;
  final Quote? currentQuote;
  final bool isLoading;

  const QuoteActions({
    super.key,
    required this.onFetchNewQuote,
    this.currentQuote,
    this.isLoading = false,
  });

  void _copyToClipboard(BuildContext context) {
    if (currentQuote == null) return;
    final text = '"${currentQuote!.text}" — ${currentQuote!.author}';
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle_outline, color: Colors.white),
            SizedBox(width: 10),
            Text('Quote copied to clipboard!'),
          ],
        ),
        backgroundColor: const Color(0xFF6C5CE7),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Primary Button: "New Quote"
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: isLoading ? null : onFetchNewQuote,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6C5CE7),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              elevation: 6,
            ),
            child: isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.5,
                    ),
                  )
                : const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.refresh_rounded, size: 22),
                      SizedBox(width: 10),
                      Text(
                        'New Quote',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
        const SizedBox(height: 16),
        // Secondary Actions (Copy)
        if (currentQuote != null)
          IconButton.filledTonal(
            onPressed: () => _copyToClipboard(context),
            icon: const Icon(Icons.copy_rounded),
            tooltip: 'Copy Quote',
            style: IconButton.styleFrom(
              backgroundColor: Colors.white.withAlpha(25),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(14),
            ),
          ),
      ],
    );
  }
}
