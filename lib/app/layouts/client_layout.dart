import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stichit/app/const/colors.dart';
import 'package:stichit/app/routes/routes.dart';
import 'package:stichit/ui_commons/buttons/custom_button.dart';
import 'package:stichit/ui_commons/cards/logo_card.dart';
import 'package:stichit/ui_commons/icons/custom_svg_icon.dart';

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
      backgroundColor: CustomColors.white,
      body: Column(
        children: [
          //top navigation bar
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
                          'Rugs',
                          style: TextStyle(
                            fontSize: 17,
                            color: CustomColors.black,
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
                          'About',
                          style: TextStyle(
                            fontSize: 17,
                            color: CustomColors.black,
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
                          'Contact',
                          style: TextStyle(
                            fontSize: 17,
                            color: CustomColors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    Container(
                      // padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: CustomColors.searchFormBack,
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      width: 400,
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: 'Search for rugs...',
                            hintStyle: TextStyle(
                                color: CustomColors.black.withOpacity(0.5),
                                fontSize: 14),
                            filled: true,
                            fillColor: CustomColors.searchFormBack,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40.0),
                              borderSide: BorderSide.none,
                            ),
                            // contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, top: 3, bottom: 3, right: 3),
                              child: customSvgIcon(
                                  path: "assets/icons/search.svg",
                                  width: 10,
                                  height: 10,
                                  iconColor:
                                      CustomColors.black.withOpacity(0.5)),
                            )),
                        style: const TextStyle(color: CustomColors.white),
                      ),
                    ),
                    const SizedBox(width: 20),
                    CustomButton(
                      label: 'Sign In',
                      isOutline: false,
                      radius: 40,
                      primaryColor: orange,
                      onPressed: () {
                        GoRouter.of(context).go(UserRoutes.login);
                      },
                    ),
                    const SizedBox(width: 15),
                    CustomButton(
                      label: 'Sign Up',
                      isOutline: true,
                      radius: 40,
                      primaryColor: orange,
                      primaryTextColor: CustomColors.white,
                      backgroundColor: CustomColors.white,
                      onPressed: () {
                        GoRouter.of(context).go(UserRoutes.signUp);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
          //divider line
          Divider(
            color: CustomColors.grey.withOpacity(0.4),
            thickness: 1,
          ),

          Expanded(
            child: widget.child,
          ),
        ],
      ),
    );
  }
}
