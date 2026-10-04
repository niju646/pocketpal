import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:pocket_pal/core/shared/bottom_nav/controller/bottom_nav_controller.dart';
import 'package:pocket_pal/features/analysis/screens/reports_screen.dart';
import 'package:pocket_pal/features/home/screens/home_screen.dart';
import 'package:pocket_pal/features/profile/screens/profile_screen.dart';
import 'package:pocket_pal/features/reminders/screens/reminder_screen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  DateTime? lastPressed;

  List<Widget> _getPages() {
    return [
      const HomeScreen(),
      const ReportsScreen(),
      const ReminderScreen(),
      const ProfileScreen(),
    ];
  }

  List<BottomNavigationBarItem> _getBottomNavItems() {
    return [
      _bottomNavItem(icon: HugeIcons.strokeRoundedHome05, label: 'Home'),
      _bottomNavItem(
        icon: HugeIcons.strokeRoundedAnalytics01,
        label: 'Analytics',
      ),
      _bottomNavItem(
        icon: HugeIcons.strokeRoundedNotification02,
        label: 'Reminders',
      ),
      _bottomNavItem(icon: HugeIcons.strokeRoundedUser, label: 'Profile'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final pages = _getPages();
    final navItems = _getBottomNavItems();

    return BlocBuilder<BottomNavbarCubit, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          body: IndexedStack(index: currentIndex, children: pages),
          bottomNavigationBar: SizedBox(
            height: 70,
            child: BottomNavigationBar(
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              currentIndex: currentIndex,
              selectedItemColor: Colors.black,
              unselectedItemColor: const Color(0xFF848484),
              selectedFontSize: 12,
              unselectedFontSize: 12,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
              onTap: (index) {
                context.read<BottomNavbarCubit>().setIndex(index);
              },
              items: navItems,
            ),
          ),
        );
      },
    );
  }

  BottomNavigationBarItem _bottomNavItem({
    required dynamic icon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: HugeIcon(icon: icon, size: 24),
      activeIcon: HugeIcon(icon: icon, size: 26),
      label: label,
    );
  }
}
