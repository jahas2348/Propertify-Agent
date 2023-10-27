import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:propertify_for_agents/data/shared_preferences/shared_preferences.dart';
import 'package:propertify_for_agents/resources/colors/app_colors.dart';
import 'package:propertify_for_agents/resources/fonts/getx_localization/languages.dart';
import 'package:propertify_for_agents/resources/routes/routes.dart';
import 'package:propertify_for_agents/utils/dependency_binding.dart';
import 'package:get/get.dart';
import 'package:propertify_for_agents/views/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await FlutterConfig.loadEnvVariables();
  await Firebase.initializeApp();
  await SharedPref.instance.initStorage();
  runApp(propertify_for_agents());
}

class propertify_for_agents extends StatelessWidget {
  const propertify_for_agents({super.key});
 
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return GetMaterialApp(
      initialBinding: InitController(),
      home: SplashScreen(),
      getPages: AppRoutes.appRoutes(),
      translations: Languages(),
      locale: Locale('en','US'),
      fallbackLocale: Locale('en','US'),
      theme: ThemeData(
        progressIndicatorTheme: ProgressIndicatorThemeData(
            color: AppColors.primaryColor.shade100,
            circularTrackColor: AppColors.primaryColor),
        brightness: Brightness.light, // Use the dark theme
        fontFamily: 'gilroy', // Set your custom font here
        primaryColor: AppColors.primaryColor,
        primaryColorDark: AppColors.primaryColor,
        primaryColorLight: AppColors.primaryColor,
        hintColor: AppColors.primaryColor,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
