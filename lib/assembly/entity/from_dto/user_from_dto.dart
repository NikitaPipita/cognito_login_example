import 'package:cognito_login_example/assembly/factory.dart';
import 'package:cognito_login_example/data/model/user.dart';
import 'package:cognito_login_example/domain/entity/user.dart';

class UserFromDtoFactory implements Factory<User, UserDto> {
  @override
  User create(UserDto arg) => User(
        id: arg.id,
        email: arg.email,
      );
}
