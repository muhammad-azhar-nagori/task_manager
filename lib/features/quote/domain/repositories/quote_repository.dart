import '../entities/quote_entity.dart';

abstract class QuoteRepository {
  Future<QuoteEntity> getRandomQuote();
}
