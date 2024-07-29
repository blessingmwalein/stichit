import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stichit/app/const/colors.dart';
import 'package:stichit/app/routes/routes.dart';
import 'package:stichit/ui_commons/buttons/custom_button.dart';
import 'package:stichit/ui_commons/cards/logo_card.dart';

class ClientLayout extends StatefulWidget {
  final Widget child;
  const ClientLayout({super.key, required this.child});

  @override
  State<ClientLayout> createState() => _ClientLayoutState();
}

class _ClientLayoutState extends State<ClientLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.lightBackGround,
      body: Column(
        children: [
          //top navigation bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const LogoCard(
                    backgroundColor: CustomColors.white, width: 80, height: 80),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          'Services',
                          style: TextStyle(
                            fontSize: 20,
                            color: CustomColors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    //Resouces
                    TextButton(
                      onPressed: () {},
                      child: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          'Resources',
                          style: TextStyle(
                            fontSize: 20,
                            color: CustomColors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    TextButton(
                      onPressed: () {},
                      child: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          'Pricing',
                          style: TextStyle(
                            fontSize: 20,
                            color: CustomColors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    TextButton(
                      onPressed: () {},
                      child: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          'Shop',
                          style: TextStyle(
                            fontSize: 20,
                            color: CustomColors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    CustomButton(
                      label: 'Sign In',
                      isOutline: false,
                      primaryColor: orange,
                      onPressed: () {
                        GoRouter.of(context).go(UserRoutes.login);
                      },
                    ),
                    const SizedBox(width: 15),
                    CustomButton(
                      label: 'Sign Up',
                      isOutline: true,
                      primaryColor: orange,
                      primaryTextColor: CustomColors.white,
                      backgroundColor: Colors.transparent,
                      onPressed: () {
                        GoRouter.of(context).go(UserRoutes.signUp);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: widget.child,
          ),
        ],
      ),
    );
  }
}
