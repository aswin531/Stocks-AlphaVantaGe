import 'package:flutter/material.dart';
import 'package:stockapi/core/theme/customcolors.dart';

AppBar buildAppBar() {
    return AppBar(
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
    );
  }
