import 'package:hive/hive.dart';
    part 'stock_model.g.dart';
    
@HiveType(typeId: 2)
class StockModel {
  @HiveField(1)
  final String symbol;

  @HiveField(2)
  final String price;

  StockModel({
    required this.symbol,
    required this.price,
  });

  factory StockModel.fromJson(Map<String, dynamic> json) {
    return StockModel(
      symbol: json["01. symbol"],
      price: json["05. price"],
    );
  }
}
