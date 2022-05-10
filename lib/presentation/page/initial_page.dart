import 'package:flutter/material.dart';
import 'package:cognito_login_example/presentation/page/sign_in/login/login_page.dart';
import 'package:cognito_login_example/spine/dependency_injection/dependency_injection.dart'
    as di;

class InitialPage extends StatelessWidget {
  static const route = '/';

  const InitialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoginPage(
      authBloc: di.getIt.get(),
    );
  }
}
