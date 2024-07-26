import 'package:flutter/material.dart';
import 'package:stichit/app/const/colors.dart';
import 'package:stichit/app/layouts/widgets/actions_panel.dart';
import 'package:stichit/app/layouts/widgets/sidebar.dart';
import 'package:stichit/app/layouts/widgets/top_nav.dart';

class MainLayout extends StatefulWidget {
  final Widget child;
  final List<String> crumbs;
  final List<Widget>? actionDrawers; // Updated to a list of widgets
  final bool isOpened;
  // final VoidCallback? onClickedOut

  const MainLayout({
    super.key,
    required this.child,
    required this.crumbs,
    this.actionDrawers, // List of widgets for actions
    required this.isOpened,
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.darkBackGround,
      body: Stack(
        children: [
          Row(
            children: [
              // Fixed Sidebar
              const SideBar(),
              // Main Content Area
              Expanded(
                child: Column(
                  children: [
                    // Top Navigation Bar
                    TopNavBar(
                      crumbs: widget.crumbs,
                      // onMenuPressed: _toggleDrawer, // Assuming you have a menu button to toggle the drawer
                    ),
                    // Main Content
                    Expanded(
                      child: Center(
                        child: widget.child,
                      ),
                    ),
                  ],
                ),
              ),
              // Right Notification Panel
              const RightActionsPanel(),
            ],
          ),
          if (widget.isOpened && widget.actionDrawers != null)
            GestureDetector(
              onTap: () {
                setState(() {
                  // widget.isOpened =
                  //     false; // Close the drawer when clicking outside
                });
              },
              child: Container(
                color: Colors.black54, // Semi-transparent background
              ),
            ),
          if (widget.isOpened && widget.actionDrawers != null)
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: widget.actionDrawers!,
              ),
            ),
        ],
      ),
    );
  }
}
