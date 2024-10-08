import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockapi/core/theme/customcolors.dart';
import 'package:stockapi/feature/stock/bloc/stock_bloc.dart';
import 'package:stockapi/feature/stock/pages/widgets/appbar.dart';
import 'package:stockapi/feature/stock/pages/widgets/emptywatchlist.dart';
import 'package:stockapi/feature/stock/pages/widgets/watchlistitem.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: const WatchlistAppBar(),
      body: BlocBuilder<StockBloc, StockState>(
        builder: (context, state) {
          if (state is StockWatchlistLoaded) {
            return _buildWatchlistContent(context, state);
          }
          return const Center(
            child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(CustomColors.accentColor),
            ),
          );
        },
      ),
    );
  }

  Widget _buildWatchlistContent(
      BuildContext context, StockWatchlistLoaded state) {
    if (state.watchlist.isEmpty) {
      return const EmptyWatchlist();
    }
    return WatchlistItemList(watchlist: state.watchlist);
  }
}
