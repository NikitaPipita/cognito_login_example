import 'package:cognito_login_example/presentation/page/initial_page.dart';

import 'presentation/router/router_generator.dart';
import 'presentation/theme/theme.dart';
import 'spine/dependency_injection/dependency_injection.dart' as di;
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  di.setup();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cognito example',
      theme: theme,
      onGenerateRoute: RouterGenerator.generateRoute,
      initialRoute: InitialPage.route,
    );
  }
}
