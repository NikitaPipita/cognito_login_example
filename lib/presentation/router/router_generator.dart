import 'package:flutter/material.dart';
import 'package:cognito_login_example/presentation/page/initial_page.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case InitialPage.route:
        return MaterialPageRoute(
          settings: const RouteSettings(name: InitialPage.route),
          builder: (_) => const InitialPage(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text(
                'No route defined for ${settings.name}',
              ),
            ),
          ),
        );
    }
  }
}
