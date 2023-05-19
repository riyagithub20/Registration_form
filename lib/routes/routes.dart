import 'package:flutter/material.dart';
import 'package:sign_up/registration/screens/registration_form_screen.dart';
import 'package:sign_up/routes/routes_names.dart';

import '../registration/screens/preview_registration_screen.dart';
import '../splash_Screen/screens/splash_screen.dart';

class RouteGenerator {
  Route<dynamic> generateRoute(RouteSettings settings) {
    final Object? args = settings.arguments;

    return MaterialPageRoute(
        settings: settings,
        builder: (_) {
          switch (settings.name) {
            case RouteNames.splashScreen:
              return SplashScreen();

            case RouteNames.registrationScreen:
              return RegistrationScreen();

             case RouteNames.previewRegistration:
              return PreviewRegistration(userId: "",url: "",);

                 default:
            return const SizedBox();
          }
          
        });
  }
}
