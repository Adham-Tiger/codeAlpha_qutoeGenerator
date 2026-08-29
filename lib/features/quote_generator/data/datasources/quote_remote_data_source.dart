import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/errors/exceptions.dart';
import '../models/quote_model.dart';

/// Abstract contract for remote API quote data fetching.
abstract class QuoteRemoteDataSource {
  Future<QuoteModel> getRandomQuote();
}

/// Concrete implementation connecting to AdviceSlip REST API.
/// Endpoint: https://api.adviceslip.com/advice
class QuoteRemoteDataSourceImpl implements QuoteRemoteDataSource {
  final http.Client client;
  static const String baseUrl = 'https://api.adviceslip.com/advice';

  QuoteRemoteDataSourceImpl({http.Client? client}) : client = client ?? http.Client();

  @override
  Future<QuoteModel> getRandomQuote() async {
    try {
      final response = await client.get(
        Uri.parse(baseUrl),
        headers: {
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonMap = jsonDecode(response.body) as Map<String, dynamic>;
        return QuoteModel.fromJson(jsonMap);
      } else {
        throw ServerException('Server returned HTTP status ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException('Failed to fetch quote from AdviceSlip API: $e');
    }
  }
}
