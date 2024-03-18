import 'package:flutter/material.dart';
import 'package:propertify_for_agents/resources/colors/app_colors.dart';

ThemeData AppTheme() {
    return ThemeData(
      useMaterial3: false,
      progressIndicatorTheme: ProgressIndicatorThemeData(
          color: AppColors.primaryColor.shade100,
          circularTrackColor: AppColors.primaryColor),
      // brightness: Brightness.light, // Use the dark theme
      fontFamily: 'gilroy', // Set your custom font here
      primaryColor: AppColors.primaryColor,
      primaryColorDark: AppColors.primaryColor,
      primaryColorLight: AppColors.primaryColor,
      hintColor: AppColors.primaryColor,
    );
  }