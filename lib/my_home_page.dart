import 'package:flutter/material.dart';
import 'package:name_randomizer/screens/favorites_screen.dart';
import 'package:name_randomizer/screens/main_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  Widget get page {
    switch (selectedIndex) {
      case 0:
        return const MainScreen();
      case 1:
        return const FavoritesScreen();
      default:
        throw UnimplementedError('Invalid index $selectedIndex');
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveIconColor = Theme.of(context).colorScheme.onPrimary;

    return LayoutBuilder(builder: (context, constraints) {
      final isDesktop = constraints.maxWidth >= 600;

      return Scaffold(
        body: SafeArea(
          child: Row(
            children: [
              SafeArea(
                child: NavigationRail(
                  extended: isDesktop,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(
                        Icons.home,
                      ),
                      label: Text(
                        'Home',
                      ),
                    ),
                    NavigationRailDestination(
                      icon: Icon(
                        Icons.favorite,
                      ),
                      label: Text(
                        'Favorites',
                      ),
                    ),
                  ],
                  selectedIconTheme: IconThemeData(
                    color: Colors.grey.shade900,
                  ),
                  unselectedIconTheme: IconThemeData(
                    color: effectiveIconColor,
                  ),
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
              ),
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: page,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
