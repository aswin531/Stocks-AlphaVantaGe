import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockapi/core/theme/customcolors.dart';
import 'package:stockapi/feature/stock/bloc/stock_bloc.dart';
import 'package:stockapi/feature/stock/model/stock_model.dart';

class WatchlistItemList extends StatelessWidget {
  final List<StockModel> watchlist;

  const WatchlistItemList({super.key, required this.watchlist});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: watchlist.length,
      itemBuilder: (context, index) => WatchlistItem(stock: watchlist[index]),
    );
  }
}

class WatchlistItem extends StatelessWidget {
  final StockModel stock;

  const WatchlistItem({super.key, required this.stock});

  @override
  Widget build(BuildContext context) {
    final priceValue = double.tryParse(stock.price.replaceAll('\$', '')) ?? 0;
    final bool isPositive = priceValue > 0;

    return Dismissible(
      key: Key(stock.symbol),
      background: _buildDismissibleBackground(),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => _removeFromWatchlist(context),
      child: Card(
        elevation: 4,
        color: CustomColors.cardBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: const EdgeInsets.only(bottom: 12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(child: _buildStockInfo()),
              _buildPriceInfo(isPositive),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDismissibleBackground() {
    return Container(
      decoration: BoxDecoration(
        color: CustomColors.redAccent.withOpacity(0.8),
        borderRadius: BorderRadius.circular(15),
      ),
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20),
      child: const Icon(Icons.delete_outline, color: Colors.white),
    );
  }

  void _removeFromWatchlist(BuildContext context) {
    context.read<StockBloc>().add(RemoveFromWatchlist(stock.symbol));
  }

  Widget _buildStockInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              stock.symbol,
              style: const TextStyle(
                color: CustomColors.primaryText,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: CustomColors.accentColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                "NASDAQ",
                style: TextStyle(
                  color: CustomColors.accentColor,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          "Apple Inc.",
          style: TextStyle(
            color: CustomColors.secondaryText,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildPriceInfo(bool isPositive) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          stock.price,
          style: const TextStyle(
            color: CustomColors.primaryText,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color:
                (isPositive ? CustomColors.accentColor : CustomColors.redAccent)
                    .withOpacity(0.2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                color: isPositive
                    ? CustomColors.accentColor
                    : CustomColors.redAccent,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                "2.5%",
                style: TextStyle(
                  color: isPositive
                      ? CustomColors.accentColor
                      : CustomColors.redAccent,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}