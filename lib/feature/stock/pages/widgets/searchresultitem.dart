import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockapi/core/theme/customcolors.dart';
import 'package:stockapi/feature/stock/bloc/stock_bloc.dart';
import 'package:stockapi/feature/stock/model/stock_model.dart';
import 'package:stockapi/feature/stock/model/symbolsearch.dart';

class SearchResultItem extends StatelessWidget {
  final SymbolSearchModel company;

  const SearchResultItem({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: CustomColors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        title: Text(
          company.name,
          style: const TextStyle(
            color: CustomColors.primaryText,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: CustomColors.accentColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  company.symbol,
                  style: const TextStyle(
                    color: CustomColors.accentColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        trailing: ElevatedButton.icon(
          icon: const Icon(Icons.add, size: 18),
          label: const Text("Add"),
          style: ElevatedButton.styleFrom(
            backgroundColor: CustomColors.accentColor,
            foregroundColor: CustomColors.background,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          onPressed: () => _addToWatchlist(context),
        ),
      ),
    );
  }

  void _addToWatchlist(BuildContext context) {
    final stockToAdd = StockModel(
      symbol: company.symbol,
      price: company.currency,
    );
    context.read<StockBloc>().add(AddToWatchlist(stockToAdd));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: CustomColors.primaryText),
            const SizedBox(width: 8.0),
            Text(
              '${company.name} added to watchlist',
              style: const TextStyle(
                color: CustomColors.primaryText,
              ),
            ),
          ],
        ),
        backgroundColor: CustomColors.cardBackground,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}


