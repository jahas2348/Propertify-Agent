import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:propertify_for_agents/resources/colors/app_colors.dart';
import 'package:propertify_for_agents/views/home_screen/home_screen.dart';
import 'package:propertify_for_agents/views/inbox_screen/inbox_screen.dart';
import 'package:propertify_for_agents/views/profile_screen/profile_screen.dart';
import 'package:propertify_for_agents/views/saved_screen/saved_screen.dart';
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
    SavedScreen(),
    InboxScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          for (int index = 0; index < _screens.length; index++)
            AnimatedOpacity(
              opacity: _currentIndex == index ? 1.0 : 0.0,
              duration: Duration(milliseconds: 200),
              child: IgnorePointer(
                ignoring: _currentIndex != index,
                child: _screens[index],
              ),
            ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey.shade200)
          )
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: BottomNavigationBar(
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
                  child: Icon(Icons.home_max_outlined, color: AppColors.secondaryColor,),
                ),
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Icon(Icons.home_max_outlined),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                activeIcon: Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Icon(Icons.search,color: AppColors.secondaryColor,),
                ),
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Icon(Icons.search),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                activeIcon: Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Icon(Icons.bookmark_border_outlined,color: AppColors.secondaryColor,),
                ),
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Icon(Icons.bookmark_border_outlined),
                ),
                label: '',
              ),
      
              BottomNavigationBarItem(
                activeIcon: Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Icon(Icons.chat_bubble_outline_rounded,color: AppColors.secondaryColor,),
                ),
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Icon(Icons.chat_bubble_outline_rounded),
                ),
                label: '',
              ),
      
              BottomNavigationBarItem(
                activeIcon: Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Icon(Icons.person_outline_outlined,color: AppColors.secondaryColor,),
                ),
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Icon(Icons.person_outline_outlined),
                ),
                label: '',
              ),
              
              
            ],
          ),
        ),
      ),
    );
  }
}
