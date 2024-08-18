import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stichit/app/const/colors.dart';
import 'package:stichit/app/routes/routes.dart';
import 'package:stichit/ui_commons/cards/logo_card.dart';
import 'package:stichit/ui_commons/icons/custom_svg_icon.dart';
import 'package:ui_commons/ui_commons.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300, // Adjust width as needed
      padding: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: CustomColors.darkBackGround, // Sidebar background color
        border: Border(
          right: BorderSide(
            color: CustomColors.white.withOpacity(0.4),
            width: 0.3,
          ),
        ),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          TextButton(
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  const BlingUserCircleAvatar(
                    imagePath: "assets/icons/profile.jpg",
                    isOnline: true,
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Blessing Mwale',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: primaryWhite),
                      ),
                      Text(
                        'blessingmwalein@gmail.com',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                            color: primaryWhite.withOpacity(0.7)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          drawerTile(
              icon: 'assets/icons/view-grid.svg',
              title: 'Dashboard',
              subTitle: 'RawMaterial, Orders, Assets',
              onTap: () {
                // Navigator.of(context).push(EditProfilePage.route());
              }),
          drawerTile(
              title: 'Rugs',
              icon: 'assets/icons/puzzle.svg',
              subTitle: 'Sizes, Types, Color, Shape',
              onTap: () {
                GoRouter.of(context).go(AdminRoutes.rugs);
              }),
          drawerTile(
              icon: 'assets/icons/shopping-cart.svg',
              title: 'Raw Materials',
              subTitle: 'Yarn, Cloth, Glue',
              onTap: () {
                GoRouter.of(context).go(AdminRoutes.rawMaterials);
              }),
          drawerTile(
              icon: 'assets/icons/calendar-outlined.svg',
              title: 'Projects',
              subTitle: 'Finished, In Progress, Paused',
              onTap: () {
                // Navigator.of(context).push(EditProfilePage.route());
              }),
          // drawerTile(
          //     icon: 'assets/icons/shopping-bag.svg',
          //     title: 'Orders',
          //     subTitle: 'Pending, In Progress, Completed',
          //     onTap: () {
          //       // Navigator.of(context).push(EditProfilePage.route());
          //     }),
          drawerTile(
              icon: 'assets/icons/users.svg',
              title: 'Customers & Orders',
              subTitle: 'Customers List, Orders',
              onTap: () {
                GoRouter.of(context).go(AdminRoutes.customers);
              }),
          drawerTile(
              icon: 'assets/icons/logout.svg',
              title: 'Logout',
              subTitle: 'Log out of your account',
              onTap: () {
                // Navigator.of(context).push(EditProfilePage.route());
              }),
          const SizedBox(
            height: 30,
          ),
          const Padding(
            padding: EdgeInsets.all(100),
            child: LogoCard(
                backgroundColor: CustomColors.white, width: 80, height: 80),
          ),
        ],
      ),
      // child: Column(
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     TextButton(
      //       onPressed: () {},
      //       child: Padding(
      //         padding: const EdgeInsets.all(10.0),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.start,
      //           children: [
      //             const BlingUserCircleAvatar(
      //               imagePath: "assets/icons/profile.jpg",
      //               isOnline: true,
      //             ),
      //             const SizedBox(width: 10),
      //             Column(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 const Text(
      //                   'Blessing Mwale',
      //                   style: TextStyle(
      //                     color: CustomColors.white,
      //                     fontSize: 20,
      //                   ),
      //                 ),
      //                 Text(
      //                   'blessingmwalein@gmail.com',
      //                   style: TextStyle(
      //                     color: CustomColors.white.withOpacity(0.4),
      //                     fontSize: 13,
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //     // Add other sidebar items here

      //   ],
      // ),
    );
  }

  Widget drawerTile({
    required String icon,
    required String title,
    required String subTitle,
    required Function onTap,
  }) {
    return TextButton(
      onPressed: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          // color: primaryBackGroundBlack,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              //circle
              decoration: BoxDecoration(
                color: CustomColors.lightGrey,
                borderRadius: BorderRadius.circular(50),
                // border: Border.all(color: primaryWhite, width: 1),
              ),
              child: customSvgIcon(
                  iconColor: CustomColors.white.withOpacity(0.6),
                  path: icon,
                  width: 30,
                  height: 30),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: primaryWhite),
                ),
                // const SizedBox(height: 5),
                Text(
                  subTitle,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: primaryGray.withOpacity(0.6)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
