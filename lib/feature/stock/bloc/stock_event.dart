abstract class StockSearchEvent {}


class SearchStockEvent extends StockSearchEvent {
  final String query;
  SearchStockEvent(this.query);
}
