import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockapi/core/theme/customcolors.dart';
import 'package:stockapi/feature/bottomnavbar/bloc/navbar_bloc.dart';
import 'package:stockapi/feature/bottomnavbar/bloc/navbarevent.dart';
import 'package:stockapi/feature/stock/pages/homescreen.dart';
import 'package:stockapi/feature/stock/pages/watchlistscreen.dart';

class Navbarscreen extends StatelessWidget {
  const Navbarscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavbarBloc, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          body: IndexedStack(
            index: currentIndex,
            children: [
              HomeScreen(),
              const WatchlistScreen(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: CustomColors.background,
            selectedItemColor: CustomColors.accentColor,
            unselectedItemColor: CustomColors.secondaryText,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 12,
            ),
            currentIndex: currentIndex,
            onTap: (index) {
              context.read<NavbarBloc>().add(NavigationEvent(index));
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.watch_later_outlined),
                label: 'Watchlist',
              ),
            ],
          ),
        );
      },
    );
  }
}
