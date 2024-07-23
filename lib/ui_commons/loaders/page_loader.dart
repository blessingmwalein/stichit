import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stichit/app/const/colors.dart';

class PageLoader extends StatelessWidget {
  const PageLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(CustomColors.white),
      ),
    );
  }
}
