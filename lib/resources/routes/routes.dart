import 'package:get/get.dart';
import 'package:propertify_for_agents/resources/routes/routes_names.dart';
import 'package:propertify_for_agents/views/auth_screens/login_screen.dart';
import 'package:propertify_for_agents/views/auth_screens/otp_verification.dart';
import 'package:propertify_for_agents/views/splash_screen/splash_screen.dart';

class AppRoutes {
  static List<GetPage<dynamic>> appRoutes() {
    return [
      GetPage(
        name: RouteName.splashScreen,
        page: () => SplashScreen(),
        transitionDuration: Duration(milliseconds: 500),
        transition: Transition.leftToRightWithFade,
      ),
      GetPage(
        name: RouteName.loginScreen,
        page: () => LoginScreen(),
        transitionDuration: Duration(milliseconds: 500),
        transition: Transition.leftToRightWithFade,
      ),
      GetPage(
        name: RouteName.otpVerification,
        page: () => OtpVerification(),
        transitionDuration: Duration(milliseconds: 500),
        transition: Transition.leftToRightWithFade,
      ),
    ];
  }
}

