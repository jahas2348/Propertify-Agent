import 'package:flutter/material.dart';
import 'package:propertify_for_agents/resources/colors/app_colors.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/paddings.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/spaces.dart';
import 'package:propertify_for_agents/resources/fonts/app_fonts/app_fonts.dart';
import 'package:propertify_for_agents/views/settings_screen/settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Padding(
            padding: customPaddings.horizontalpadding20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customSpaces.verticalspace20,
                Text(
                  "Profile",
                  style: AppFonts.SecondaryColorText28,
                ),
              ],
            ),
          ),
          customSpaces.verticalspace10,
          Divider(),
          customSpaces.verticalspace10,
          Padding(
            padding: customPaddings.horizontalpadding20,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CircleAvatar(radius: 50),
              customSpaces.verticalspace20,
              Text(
                'David James',
                style: AppFonts.SecondaryColorText20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'davidjames@gmail.com',
                    style: AppFonts.greyText14,
                  ),
                  Text(
                    'Edit Profile',
                    style: AppFonts.PrimaryColorText14,
                  ),
                ],
              )
            ]),
          ),
          customSpaces.verticalspace20,
          Divider(),
          Padding(
            padding: customPaddings.horizontalpadding20,
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SettingsScreen(),
                ));
              },
              contentPadding: EdgeInsets.all(0),
              leading: Text(
                'Settings',
                style: AppFonts.SecondaryColorText20,
              ),
              trailing: Icon(
                Icons.settings,
                color: AppColors.secondaryColor,
              ),
            ),
          ),
          Padding(
            padding: customPaddings.horizontalpadding20,
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SettingsScreen(),
                ));
              },
              contentPadding: EdgeInsets.all(0),
              leading: Text(
                'App Info',
                style: AppFonts.SecondaryColorText20,
              ),
              trailing: Icon(
                Icons.info_outline,
                color: AppColors.secondaryColor,
              ),
            ),
          ),
          Divider(),
          Padding(
            padding: customPaddings.horizontalpadding20,
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SettingsScreen(),
                ));
              },
              contentPadding: EdgeInsets.all(0),
              leading: Text(
                'Terms & Conditions',
                style: AppFonts.SecondaryColorText20,
              ),
              trailing: Icon(
                Icons.menu_book_outlined,
                color: AppColors.secondaryColor,
              ),
            ),
          ),
          Padding(
            padding: customPaddings.horizontalpadding20,
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SettingsScreen(),
                ));
              },
              contentPadding: EdgeInsets.all(0),
              leading: Text(
                'Privacy & Policy',
                style: AppFonts.SecondaryColorText20,
              ),
              trailing: Icon(
                Icons.security_outlined,
                color: AppColors.secondaryColor,
              ),
            ),
          ),
          Padding(
            padding: customPaddings.horizontalpadding20,
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SettingsScreen(),
                ));
              },
              contentPadding: EdgeInsets.all(0),
              leading: Text(
                'Help',
                style: AppFonts.SecondaryColorText20,
              ),
              trailing: Icon(
                Icons.help_outline_outlined,
                color: AppColors.secondaryColor,
              ),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
