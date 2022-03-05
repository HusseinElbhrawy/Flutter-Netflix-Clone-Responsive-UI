import 'package:flutter/material.dart';
import 'package:netflix_clone_responsive_ui/screens/home_screen.dart';
import 'package:netflix_clone_responsive_ui/widgets/responsive_widget.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({Key? key}) : super(key: key);

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  final List _screens = [
    const HomeScreen(key: PageStorageKey('homeScreen')),
    const Scaffold(),
    const Scaffold(),
    const Scaffold(),
    const Scaffold(),
  ];

  final Map<String, IconData> _icons = {
    'Home': Icons.home,
    'Search': Icons.search,
    'Coming Soon': Icons.queue_play_next,
    'Downloads': Icons.file_download,
    'More': Icons.menu,
  };

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[currentIndex],
      bottomNavigationBar: ResponsiveWidget.isDesktop(context)
          ? null
          : BottomNavigationBar(
              selectedItemColor: Colors.white,
              currentIndex: currentIndex,
              unselectedItemColor: Colors.grey,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.black,
              onTap: (index) => setState(() {
                currentIndex = index;
              }),
              selectedFontSize: 11.0,
              unselectedFontSize: 11.0,
              items: _icons
                  .map(
                    (title, icon) {
                      return MapEntry(
                        title,
                        BottomNavigationBarItem(
                          icon: Icon(icon),
                          label: title,
                        ),
                      );
                    },
                  )
                  .values
                  .toList(),
            ),
    );
  }
}
