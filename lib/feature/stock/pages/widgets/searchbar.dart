
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockapi/core/debounce_helper.dart';
import 'package:stockapi/core/theme/customcolors.dart';
import 'package:stockapi/feature/stock/bloc/stock_bloc.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final Debouncer debouncer = Debouncer(milliseconds: 400);

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Enter company name or symbol",
          hintStyle: TextStyle(
            color: CustomColors.secondaryText.withOpacity(0.7),
          ),
          filled: true,
          fillColor: CustomColors.searchBarBackground,
          prefixIcon: const Icon(
            Icons.search,
            color: CustomColors.accentColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 16.0,
          ),
        ),
        style: const TextStyle(color: CustomColors.primaryText),
        onChanged: (query) {
          debouncer.run(() {
            context.read<StockBloc>().add(SearchStocks(query));
          });
        },
      ),
    );
  }
}