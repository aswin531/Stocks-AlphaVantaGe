import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockapi/core/debounce_helper.dart';
import 'package:stockapi/core/theme/customcolors.dart';
import 'package:stockapi/feature/stock/bloc/stock_bloc.dart';
import 'package:stockapi/feature/stock/pages/widgets/errordisplay.dart';
import 'package:stockapi/feature/stock/pages/widgets/homeappbar.dart';
import 'package:stockapi/feature/stock/pages/widgets/loadinganimation.dart';
import 'package:stockapi/feature/stock/pages/widgets/searchlist.dart';

class HomeScreen extends StatelessWidget {
  final Debouncer _debouncer = Debouncer(milliseconds: 400);

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: buildAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Search Companies",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: CustomColors.primaryText,
                ),
              ),
              const SizedBox(height: 8.0),
              Container(
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
                    _debouncer.run(() {
                      context.read<StockBloc>().add(SearchStocks(query));
                    });
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              Expanded(
                child: BlocBuilder<StockBloc, StockState>(
                  builder: (context, state) {
                    if (state is StockSearchSuccess) {
                      return SearchResultsList(
                          searchResults: state.searchResults);
                    } else if (state is StockError) {
                      return ErrorDisplay(error: state.error);
                    }
                    return const LoadingAnimation();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
