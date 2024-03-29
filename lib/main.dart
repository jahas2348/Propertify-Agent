import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:propertify_for_agents/data/shared_preferences/shared_preferences.dart';
import 'package:propertify_for_agents/resources/app_theme/app_theme.dart';
import 'package:propertify_for_agents/resources/fonts/getx_localization/languages.dart';
import 'package:propertify_for_agents/resources/routes/routes.dart';
import 'package:propertify_for_agents/utils/dependency_binding.dart';
import 'package:get/get.dart';
import 'package:propertify_for_agents/views/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPref.instance.initStorage();
  runApp(propertify_for_agents());
}

class propertify_for_agents extends StatelessWidget {
  const propertify_for_agents({super.key});

  @override
  Widget build(BuildContext context) {
    Brightness systemBrightness = MediaQuery.of(context).platformBrightness;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: systemBrightness == Brightness.light
            ? Colors.transparent
            : Colors.transparent,
        statusBarIconBrightness: systemBrightness == Brightness.light
            ? Brightness.dark
            : Brightness.dark,
        statusBarBrightness: systemBrightness,
        systemNavigationBarColor:
            systemBrightness == Brightness.light ? Colors.white : Colors.black,
        systemNavigationBarIconBrightness: systemBrightness == Brightness.light
            ? Brightness.dark
            : Brightness.light,
      ),
    );
    return GetMaterialApp(
      initialBinding: InitController(),
      getPages: AppRoutes.appRoutes(),
      translations: Languages(),
      locale: Locale('en', 'US'),
      fallbackLocale: Locale('en', 'US'),
      home: SplashScreen(),
      theme: AppTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}
