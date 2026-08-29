import 'package:equatable/equatable.dart';

/// Pure Domain Entity representing a Quote.
/// Independent of Flutter UI components and JSON/Database parsers.
class Quote extends Equatable {
  final String id;
  final String text;
  final String author;
  final String category;

  const Quote({
    required this.id,
    required this.text,
    required this.author,
    this.category = 'General',
  });

  @override
  List<Object?> get props => [id, text, author, category];
}
