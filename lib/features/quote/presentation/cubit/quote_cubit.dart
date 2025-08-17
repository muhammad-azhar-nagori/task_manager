import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_task_manager/features/quote/domain/usecases/get_random_qoute.dart';
import 'quote_state.dart';

class QuoteCubit extends Cubit<QuoteState> {
  final GetRandomQuote getRandomQuote;

  QuoteCubit({required this.getRandomQuote}) : super(QuoteInitial());

  Future<void> fetchQuote() async {
    emit(QuoteLoading());
    try {
      final quote = await getRandomQuote();
      emit(QuoteLoaded(quote));
    } catch (e) {
      emit(QuoteError(e.toString()));
    }
  }
}
