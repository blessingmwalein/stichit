import 'package:flutter/material.dart';
import 'package:stichit/app/const/colors.dart';
import 'package:stichit/app/layouts/client_layout.dart';
import 'package:stichit/home/widgets/banner.dart';

class ClientHomePage extends StatelessWidget {
  const ClientHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ClientLayout(
        child: Container(
      //infinitive height
      width: double.infinity,
      decoration: const BoxDecoration(
        color: CustomColors.white,
      ),
      child: const SingleChildScrollView(
        child: Column(
          children: [
            // SizedBox(height: 10),
            HomeBanner(),
          ],
        ),
      ),
    ));
  }
}
