import 'package:cognito_login_example/domain/entity/user.dart';

abstract class GetCurrentUserUseCase {
  Future<User?> call();
}
