import '../entities/quote_entity.dart';
import '../repositories/quote_repository.dart';

class GetRandomQuote {
  final QuoteRepository repository;

  GetRandomQuote(this.repository);

  Future<QuoteEntity> call() async {
    return await repository.getRandomQuote();
  }
}
