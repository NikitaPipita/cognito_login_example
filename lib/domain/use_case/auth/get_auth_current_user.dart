import 'package:cognito_login_example/domain/entity/user.dart';
import 'package:cognito_login_example/spine/service/auth.dart';
import 'package:cognito_login_example/spine/use_case/auth/get_current_user.dart';

class GetAuthCurrentUserUseCase implements GetCurrentUserUseCase {
  final AuthService _authService;

  GetAuthCurrentUserUseCase(this._authService);

  @override
  Future<User?> call() => _authService.getCurrentUser();
}
