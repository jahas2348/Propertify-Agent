import 'package:flutter/material.dart';
import 'package:propertify_for_agents/resources/assets/propertify_icons.dart';
import 'package:propertify_for_agents/resources/colors/app_colors.dart';
import 'package:propertify_for_agents/views/home_screen/home_screen.dart';
import 'package:propertify_for_agents/views/inbox_screen/inbox_screen.dart';
import 'package:propertify_for_agents/views/profile_screen/profile_screen.dart';
import 'package:propertify_for_agents/views/saved_screen/sold_properties_screen.dart';

import 'package:propertify_for_agents/views/search_screen/search_screen.dart';

class NavigationItems extends StatefulWidget {
  NavigationItems({super.key});

  @override
  State<NavigationItems> createState() => _NavigationItemsState();
}

class _NavigationItemsState extends State<NavigationItems> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    HomeScreen(),
    SearchScreen(),
    InboxScreen(),
    SoldPropertiesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey.shade500,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          elevation: 0,
          enableFeedback: false,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 2),
                child:
                    Icon(PropertifyIcons.home, color: AppColors.secondaryColor),
              ),
              icon: Padding(
                padding: EdgeInsets.only(bottom: 2),
                child: Icon(PropertifyIcons.home),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 2),
                child: Icon(PropertifyIcons.search,
                    color: AppColors.secondaryColor),
              ),
              icon: Padding(
                padding: EdgeInsets.only(bottom: 2),
                child: Icon(PropertifyIcons.search),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 2),
                child:
                    Icon(PropertifyIcons.chat, color: AppColors.secondaryColor),
              ),
              icon: Padding(
                padding: EdgeInsets.only(bottom: 2),
                child: Icon(PropertifyIcons.chat),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 2),
                child: Icon(Icons.check_circle_outline_outlined,
                    color: AppColors.secondaryColor),
              ),
              icon: Padding(
                padding: EdgeInsets.only(bottom: 2),
                child: Icon(Icons.check_circle_outline_outlined),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 2),
                child:
                    Icon(PropertifyIcons.user, color: AppColors.secondaryColor),
              ),
              icon: Padding(
                padding: EdgeInsets.only(bottom: 2),
                child: Icon(PropertifyIcons.user),
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
