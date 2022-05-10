import 'package:cognito_login_example/spine/service/auth.dart';
import 'package:cognito_login_example/spine/use_case/auth/sign_out.dart';

class AuthSignOutUseCase implements SignOutUseCase {
  final AuthService _authService;

  AuthSignOutUseCase(this._authService);

  @override
  Future<void> call() => _authService.signOut();
}
