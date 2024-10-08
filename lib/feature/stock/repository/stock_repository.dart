import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stockapi/core/constants.dart';
import 'package:stockapi/core/exceptions.dart';
import 'package:stockapi/feature/stock/model/stock_model.dart';
import 'package:stockapi/feature/stock/model/symbolsearch.dart';

class StockRepository {
  final String apiKey = alphaVantageKey;

  Future<List<SymbolSearchModel>> searchCompanies(String query) async {
    print(' Initiating API call to search for: $query');
    final url = Uri.parse(
        'https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=$query&apikey=$apiKey');

    try {
      print(
          ' Sending request to: ${url.toString().replaceAll(apiKey, 'API_KEY')}');
      final response = await http.get(url);
            final Map<String, dynamic> responseBody = json.decode(response.body);

      print(' Received response with status code: ${response.statusCode}');
 if (responseBody.containsKey('Information') && 
          responseBody['Information'].toString().contains('API rate limit')) {
        throw RateLimitException('API rate limit reached. Please try again later.');
      }
      if (response.statusCode == 200) {
        print(' Successful response received');
        final Map<String, dynamic> responseBody = json.decode(response.body);
        print(' Response body structure: ${responseBody.keys.toString()}');

        if (!responseBody.containsKey('bestMatches')) {
          print(' Response doesn\'t contain bestMatches key');
          print(' Full response body: ${response.body}');
          throw Exception('Invalid response format');
        }

        final List<dynamic> results = responseBody['bestMatches'];
        print(' Found ${results.length} matches');
        return results.map((json) => SymbolSearchModel.fromJson(json)).toList();
      } else {
        print(' Failed response with body: ${response.body}');
        throw Exception('Failed to load search results');
      }
    } catch (e) {
      print(' Error during API call: $e');
      rethrow;
    }
  }

  Future<StockModel> getStockPrice(String symbol) async {
    print(' Initiating API call to get price for symbol: $symbol');
    final url = Uri.parse(
        'https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=$symbol&apikey=$apiKey');

    try {
      print(
          ' Sending request to: ${url.toString().replaceAll(apiKey, 'API_KEY')}');
      final response = await http.get(url);
      print(' Received response with status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        print(' Successful response received');
        final Map<String, dynamic> responseBody = json.decode(response.body);
        print(' Response body structure: ${responseBody.keys.toString()}');

        if (!responseBody.containsKey('Global Quote')) {
          print(' Response doesn\'t contain Global Quote key');
          print(' Full response body: ${response.body}');
          throw Exception('Invalid response format');
        }

        final Map<String, dynamic> data = responseBody['Global Quote'];
        print(' Received data for symbol: $symbol');
        return StockModel.fromJson(data);
      } else {
        print(' Failed response with body: ${response.body}');
        throw Exception('Failed to load stock price');
      }
    } catch (e) {
      print(' Error during API call: $e');
      rethrow;
    }
  }
}
