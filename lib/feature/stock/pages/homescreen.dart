import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:stockapi/core/debounce_helper.dart';
import 'package:stockapi/core/theme/customcolors.dart';
import 'package:stockapi/feature/stock/bloc/stock_bloc.dart';
import 'package:stockapi/feature/stock/model/stock_model.dart';

class HomeScreen extends StatelessWidget {
  final Debouncer _debouncer = Debouncer(milliseconds: 400);

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Stock Search",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: CustomColors.primaryText,
          ),
        ),
        backgroundColor: CustomColors.background,
      ),
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
                      return ListView.builder(
                        itemCount: state.searchResults.length,
                        itemBuilder: (context, index) {
                          final company = state.searchResults[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Card(
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
                                          color: CustomColors.accentColor
                                              .withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
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
                                  onPressed: () {
                                    final stockToAdd = StockModel(
                                      symbol: company.symbol,
                                      price: company.currency,
                                    );
                                    context
                                        .read<StockBloc>()
                                        .add(AddToWatchlist(stockToAdd));

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Row(
                                          children: [
                                            const Icon(Icons.check_circle,
                                                color:
                                                    CustomColors.primaryText),
                                            const SizedBox(width: 8.0),
                                            Text(
                                              '${company.name} added to watchlist',
                                              style: const TextStyle(
                                                color: CustomColors.primaryText,
                                              ),
                                            ),
                                          ],
                                        ),
                                        backgroundColor:
                                            CustomColors.cardBackground,
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else if (state is StockError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              color: CustomColors.errorColor,
                              size: 48,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              state.error,
                              style: const TextStyle(
                                color: CustomColors.errorColor,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    }
                    return Center(
                      child: Lottie.asset('assets/lottie/loadingstock.json',
                          height: 150, backgroundLoading: true),
                      // child: CircularProgressIndicator(
                      //   valueColor: AlwaysStoppedAnimation<Color>(
                      //     CustomColors.accentColor,
                      //   ),
                      // ),
                    );
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
