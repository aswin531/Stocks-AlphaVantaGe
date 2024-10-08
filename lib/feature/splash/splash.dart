import 'package:flutter/material.dart';
import 'package:stockapi/feature/bottomnavbar/pages/navbarscreen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 200), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Navbarscreen()));
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              'assets/images/premium.jpg',
              width: 200,
              height: 200,
            ),
          ),
          const Center(
            child: Text(
              'Loading...',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
