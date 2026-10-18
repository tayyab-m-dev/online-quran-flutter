
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../screens/home/home_screen.dart';
import '../screens/courses/courses_screen.dart';
import '../screens/profile/profile_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  void _navigateTo(int index) {
    if (index < 0 || index > 3) return;

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isDesktop = constraints.maxWidth >= 768;

        final screens = <Widget>[
          HomeScreen(onNavigate: _navigateTo),
          PlaceholderScreen(
            title: 'Quran',
            onNavigate: _navigateTo,
          ),
          CoursesScreen(onNavigate: _navigateTo),
          ProfileScreen(onNavigate: _navigateTo),
        ];

        return Scaffold(
          body: IndexedStack(
            index: _selectedIndex,
            children: screens,
          ),
          bottomNavigationBar: isDesktop
              ? null
              : NavigationBar(
            selectedIndex: _selectedIndex,
            onDestinationSelected: _navigateTo,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.menu_book_outlined),
                selectedIcon: Icon(Icons.menu_book),
                label: 'Quran',
              ),
              NavigationDestination(
                icon: Icon(Icons.school_outlined),
                selectedIcon: Icon(Icons.school),
                label: 'Courses',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({
    super.key,
    required this.title,
    required this.onNavigate,
  });

  final String title;
  final ValueChanged<int> onNavigate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$title screen coming soon',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppTheme.forestGreen,
              ),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () => onNavigate(0),
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
