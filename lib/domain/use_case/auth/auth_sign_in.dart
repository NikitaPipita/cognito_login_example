import 'package:cognito_login_example/domain/entity/user.dart';
import 'package:cognito_login_example/spine/service/auth.dart';
import 'package:cognito_login_example/spine/use_case/auth/sign_in.dart';

class AuthSignInUseCase implements SignInUseCase {
  final AuthService _authService;

  AuthSignInUseCase(this._authService);

  @override
  Future<User> call(String email, String password) =>
      _authService.signIn(email, password);
}
