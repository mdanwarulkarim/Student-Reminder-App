import 'package:get/get.dart';
import 'package:student_reminder/pages/bottom_nav_page.dart';
import 'package:student_reminder/pages/forget_page.dart';
import 'package:student_reminder/pages/info_page.dart';
import 'package:student_reminder/pages/notification_page.dart';
import 'package:student_reminder/pages/settings_page.dart';
import 'package:student_reminder/pages/sign_in_page.dart';
import 'package:student_reminder/pages/sign_up_page.dart';
import 'package:student_reminder/pages/weather_page.dart';
import 'package:student_reminder/pages/welcome_page.dart';

class Routes {
  static const String initial = '/';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String welcome = '/welcome';
  static const String settings = '/settings';
  static const String privacyPolicy = '/privacy-policy';
  static const String weather = '/weather';
  static const String notification = '/notification';
  static const String forget = '/forget';

  static String getInitialRoute() => initial;
  static String getSignInRoute() => signIn;
  static String getSignUpRoute() => signUp;
  static String getWelcomeRoute() => welcome;
  static String getPrivacyPolicyRoute() => privacyPolicy;
  static String getSettingsRoute() => settings;
  static String getNotificationRoute() => notification;
  static String getWeatherRoute() => weather;
  static String getForgetRoute() => forget;

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => const BottomNavPage()),
    GetPage(name: signIn, page: () => const SignInPage()),
    GetPage(name: signUp, page: () => const SignUpPage()),
    GetPage(name: welcome, page: () => const WelcomePage()),
    GetPage(name: privacyPolicy, page: () => const InfoPage(isContactUs: false)),
    GetPage(name: settings, page: () => const SettingsPage()),
    GetPage(name: notification, page: () => const NotificationPage()),
    GetPage(name: weather, page: () => const WeatherPage()),
    GetPage(name: forget, page: () => const ForgetPage()),
  ];
}