import 'package:cognito_login_example/domain/entity/user.dart';

abstract class AuthService {
  Future<User> signUp(String email, String password);

  Future<User> signIn(String email, String password);

  Future<void> signOut();

  Future<User?> getCurrentUser();
}
