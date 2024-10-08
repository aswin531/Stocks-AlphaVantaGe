import 'package:flutter/material.dart';
import 'package:stockapi/core/theme/customcolors.dart';

class WatchlistAppBar extends StatelessWidget implements PreferredSizeWidget {
  const WatchlistAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
