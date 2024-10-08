
import 'package:flutter/material.dart';
import 'package:stockapi/core/theme/customcolors.dart';

class ErrorDisplay extends StatelessWidget {
  final String error;

  const ErrorDisplay({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
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
            error,
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
}

