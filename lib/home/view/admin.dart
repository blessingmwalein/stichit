import 'package:flutter/material.dart';
import 'package:stichit/app/layouts/main_layout.dart';
import 'package:stichit/ui_commons/cards/dashboard_card.dart';
import 'package:stichit/ui_commons/cards/project_card.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  static Page<void> page() => const MaterialPage<void>(child: AdminDashboard());

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const AdminDashboard());
  }

  @override
  Widget build(BuildContext context) {
    return const MainLayout(
        isOpened: false,
        crumbs: ['Home', 'Dashboard'],
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: DashboardCard(
                    title: 'Projects',
                    icon: 'assets/icons/folder.svg',
                    total: '10',
                  ),
                ),
                Expanded(
                  child: DashboardCard(
                    title: 'Total Orders',
                    icon: 'assets/icons/currency-dollar.svg',
                    total: '10',
                  ),
                ),
                Expanded(
                  child: DashboardCard(
                    title: 'Our Clients',
                    icon: 'assets/icons/users.svg',
                    total: '10',
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ProjectCard(
                    title: 'Micky Mouse',
                    projectIcon: 'assets/icons/folder.svg',
                    userIcon: 'assets/icons/profile.jpg',
                    date: 'Jun 24 2024',
                    status: 'In Progress',
                    progress: 0.3,
                  ),
                ),
                Expanded(
                  child: ProjectCard(
                    title: 'Stichit Rug',
                    projectIcon: 'assets/icons/currency-dollar.svg',
                    userIcon: 'assets/icons/profile.jpg',
                    date: 'Jun 24 2024',
                    status: 'In Progress',
                    progress: 0.5,
                  ),
                ),
                Expanded(
                  child: ProjectCard(
                    title: 'Riquid Class Rug ',
                    projectIcon: 'assets/icons/users.svg',
                    userIcon: 'assets/icons/profile.jpg',
                    date: 'Jun 24 2024',
                    status: 'Processing',
                    progress: .12,
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
