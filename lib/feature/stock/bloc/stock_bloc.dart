import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:stockapi/core/exceptions.dart';
import 'package:stockapi/feature/stock/repository/stock_repository.dart';
import 'package:stockapi/feature/stock/model/stock_model.dart';
import 'package:stockapi/feature/stock/model/symbolsearch.dart';

// Events
abstract class StockEvent {}

class SearchStocks extends StockEvent {
  final String query;
  SearchStocks(this.query);
}

class AddToWatchlist extends StockEvent {
  final StockModel stock;
  AddToWatchlist(this.stock);
}

class RemoveFromWatchlist extends StockEvent {
  final String symbol;
  RemoveFromWatchlist(this.symbol);
}

// States
abstract class StockState {}

class StockInitial extends StockState {}

class StockSearchSuccess extends StockState {
  final List<SymbolSearchModel> searchResults;
  StockSearchSuccess(this.searchResults);
}

class StockError extends StockState {
  final String error;
  StockError(this.error);
}

class StockWatchlistLoaded extends StockState {
  final List<StockModel> watchlist;
  StockWatchlistLoaded(this.watchlist);
}

class StockBloc extends Bloc<StockEvent, StockState> {
  final StockRepository repository;
  final Box<StockModel> watchlistBox;

  StockBloc(this.repository, this.watchlistBox) : super(StockInitial()) {
    on<SearchStocks>((event, emit) async {
      debugPrint(' Received SearchStocks event with query: ${event.query}');
      try {
        debugPrint(' Attempting to search companies...');
        final results = await repository.searchCompanies(event.query);
        debugPrint(' Search successful, found ${results.length} results');
        emit(StockSearchSuccess(results));
      } on RateLimitException catch (e) {
        debugPrint(' Rate limit exceeded: $e');
        emit(StockError('API rate limit reached. Please try again later.'));
      } catch (e) {
        debugPrint(' Error during search: $e');
        emit(StockError('Failed to search stocks.'));
      }
    });

    on<AddToWatchlist>((event, emit) async {
      debugPrint(' Adding ${event.stock.symbol} to watchlist');
      watchlistBox.put(event.stock.symbol, event.stock);
      final updatedList = watchlistBox.values.toList();
      debugPrint(' Watchlist now contains ${updatedList.length} stocks');
      emit(StockWatchlistLoaded(updatedList));
    });

    on<RemoveFromWatchlist>((event, emit) async {
      debugPrint('Removing ${event.symbol} from watchlist');
      watchlistBox.delete(event.symbol);
      final updatedList = watchlistBox.values.toList();
      debugPrint(' Watchlist now contains ${updatedList.length} stocks');
      emit(StockWatchlistLoaded(updatedList));
    });
  }

  void loadWatchlist() {
    debugPrint(' Loading watchlist');
    final list = watchlistBox.values.toList();
    debugPrint(' Loaded ${list.length} stocks from watchlist');
    // ignore: invalid_use_of_visible_for_testing_member
    emit(StockWatchlistLoaded(list));
  }
}
