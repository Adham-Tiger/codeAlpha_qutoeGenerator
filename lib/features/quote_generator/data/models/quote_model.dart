import '../../domain/entities/quote.dart';

/// Data Model (DTO) extending pure [Quote] entity with JSON parsing capabilities.
/// Handles API responses that don't return an explicit author field (e.g. AdviceSlip API).
class QuoteModel extends Quote {
  const QuoteModel({
    required super.id,
    required super.text,
    required super.author,
    super.category,
  });

  /// Factory constructor to convert JSON map to [QuoteModel].
  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    // Un-nest 'slip' object if coming from AdviceSlip API
    final Map<String, dynamic> slipJson =
        (json.containsKey('slip') && json['slip'] is Map<String, dynamic>)
            ? json['slip'] as Map<String, dynamic>
            : json;

    return QuoteModel(
      id: slipJson['id']?.toString() ??
          (slipJson['advice'] != null
              ? slipJson['advice'].hashCode.toString()
              : DateTime.now().millisecondsSinceEpoch.toString()),
      text: slipJson['advice'] as String? ??
          slipJson['q'] as String? ??
          slipJson['text'] as String? ??
          slipJson['content'] as String? ??
          '',
      // Fallback for APIs that don't return an author field (like AdviceSlip)
      author: slipJson['author'] as String? ??
          slipJson['a'] as String? ??
          'Daily Advice',
      category: slipJson['category'] as String? ?? 'Advice',
    );
  }

  /// Converts [QuoteModel] instance into a JSON Map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'author': author,
      'category': category,
    };
  }

  /// Converts domain [Quote] instance into [QuoteModel].
  factory QuoteModel.fromEntity(Quote entity) {
    return QuoteModel(
      id: entity.id,
      text: entity.text,
      author: entity.author,
      category: entity.category,
    );
  }
}
