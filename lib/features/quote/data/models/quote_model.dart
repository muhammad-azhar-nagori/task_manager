import '../../domain/entities/quote_entity.dart';

class QuoteModel extends QuoteEntity {
  const QuoteModel({required super.content, required super.author});

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
      content: json['q'] ?? '',
      author: json['a'] ?? 'Unknown',
    );
  }
}
