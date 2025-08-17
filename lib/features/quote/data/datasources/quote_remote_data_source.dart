import 'package:mini_task_manager/core/services/network/dio_service.dart';

import '../models/quote_model.dart';

abstract class QuoteRemoteDataSource {
  Future<QuoteModel> getRandomQuote();
}

class QuoteRemoteDataSourceImpl implements QuoteRemoteDataSource {
  final ApiService apiService;

  QuoteRemoteDataSourceImpl({required this.apiService});

  @override
  Future<QuoteModel> getRandomQuote() async {
    final response =
        await apiService.get<List>('https://zenquotes.io/api/random');
    final Map<String, dynamic> data =
        response.isNotEmpty ? response.first as Map<String, dynamic> : {};
    return QuoteModel.fromJson(data);
  }
}
