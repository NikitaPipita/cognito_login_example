import 'package:cognito_login_example/domain/entity/user.dart';

abstract class SignInUseCase {
  Future<User> call(String email, String password);
}
