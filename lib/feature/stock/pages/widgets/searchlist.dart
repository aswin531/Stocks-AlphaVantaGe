import 'package:flutter/material.dart';
import 'package:stockapi/feature/stock/model/symbolsearch.dart';
import 'package:stockapi/feature/stock/pages/widgets/searchresultitem.dart';

class SearchResultsList extends StatelessWidget {
  final List<SymbolSearchModel> searchResults;

  const SearchResultsList({super.key, required this.searchResults});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final company = searchResults[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: SearchResultItem(company: company),
        );
      },
    );
  }
}