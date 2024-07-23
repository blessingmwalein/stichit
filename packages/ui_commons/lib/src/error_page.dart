// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({
    required this.errorMessage,
    super.key,
    this.onRefresh,
  });
  final String errorMessage;
  final VoidCallback? onRefresh;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Error',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(errorMessage),
          const SizedBox(height: 20),
          OutlinedButton(onPressed: onRefresh, child: const Text('Refresh')),
        ],
      ),
    );
  }
}
