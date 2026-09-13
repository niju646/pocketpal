import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_pal/core/shared/bottom_nav/controller/bottom_nav_controller.dart';
import 'package:pocket_pal/features/home/screens/home_screen.dart';
import 'package:pocket_pal/features/profile/screens/profile_screen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  DateTime? lastPressed;

  List<Widget> _getPages() {
    return [const HomeScreen(), const ProfileScreen()];
  }

  List<BottomNavigationBarItem> _getBottomNavItems() {
    return [
      _bottomNavItem(icon: Icons.home, label: 'Home'),
      _bottomNavItem(icon: Icons.person, label: 'Profile'),
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
    required IconData icon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(icon, size: 24),
      activeIcon: Icon(icon, size: 26),
      label: label,
    );
  }
}
