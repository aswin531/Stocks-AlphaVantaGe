import 'package:flutter/material.dart';
import 'package:stockapi/core/theme/customcolors.dart';
import 'package:stockapi/feature/stock/pages/homescreen.dart';

class EmptyWatchlist extends StatelessWidget {
  const EmptyWatchlist({super.key});

  @override
  Widget build(BuildContext context) {
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
            onPressed: () => _navigateToHomeScreen(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: CustomColors.accentColor,
              foregroundColor: CustomColors.background,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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

  void _navigateToHomeScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => HomeScreen(),
    ));
  }
}
