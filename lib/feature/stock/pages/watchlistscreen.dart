import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockapi/core/theme/customcolors.dart';
import 'package:stockapi/feature/stock/bloc/stock_bloc.dart';


class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CustomColors.background,
        title: const Text(
          "Watchlist",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: CustomColors.primaryText,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.analytics, color: CustomColors.accentColor),
            onPressed: () {
              // Implement analytics or summary view
            },
          ),
        ],
      ),
      body: BlocBuilder<StockBloc, StockState>(
        builder: (context, state) {
          if (state is StockWatchlistLoaded) {
            if (state.watchlist.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.format_list_bulleted,
                      size: 64,
                      color: CustomColors.secondaryText.withOpacity(0.5),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Your watchlist is empty",
                      style: TextStyle(
                        color: CustomColors.secondaryText.withOpacity(0.7),
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to search screen
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.accentColor,
                        foregroundColor: CustomColors.background,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text("Add Stocks"),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.watchlist.length,
              itemBuilder: (context, index) {
                final stock = state.watchlist[index];
              final priceValue = double.tryParse(stock.price.replaceAll('\$', '')) ?? 0;
final bool isPositive = priceValue > 0;

                return Dismissible(
                  key: Key(stock.symbol),
                  background: Container(
                    decoration: BoxDecoration(
                      color: CustomColors.redAccent.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(
                      Icons.delete_outline,
                      color: Colors.white,
                    ),
                  ),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    context
                        .read<StockBloc>()
                        .add(RemoveFromWatchlist(stock.symbol));
                  },
                  child: Card(
                    elevation: 4,
                    color: CustomColors.cardBackground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
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
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: CustomColors.accentColor
                                            .withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
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
                            ),
                          ),
                          Column(
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
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: (isPositive
                                          ? CustomColors.accentColor
                                          : CustomColors.redAccent)
                                      .withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      isPositive
                                          ? Icons.arrow_upward
                                          : Icons.arrow_downward,
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
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                CustomColors.accentColor,
              ),
            ),
          );
        },
      ),
    );
  }
}
