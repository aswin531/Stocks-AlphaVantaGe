
import 'package:hive/hive.dart';
part 'symbolsearch.g.dart';

@HiveType(typeId: 1)
class SymbolSearchModel {
  @HiveField(0)
  final String symbol;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String region;

  @HiveField(3)
  final String currency;

  SymbolSearchModel({
    required this.symbol,
    required this.name,
    required this.region,
    required this.currency,
  });

  factory SymbolSearchModel.fromJson(Map<String, dynamic> json) {
    return SymbolSearchModel(
      symbol: json['1. symbol'],
      name: json['2. name'],
      region: json['4. region'],
      currency: json['8. currency'],
    );
  }
}