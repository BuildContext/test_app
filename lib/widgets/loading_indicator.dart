import 'package:flutter/material.dart';

/// Клас [LoadingIndicator], що відображає
/// індикатор завантаження
class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
