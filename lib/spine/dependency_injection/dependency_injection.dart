import 'package:get_it/get_it.dart';

import 'auth_injection.dart' as auth;
import 'key_storage_injection.dart' as key_storage;

final getIt = GetIt.instance;

///Separate injections into different get it modules
void setup() {
  key_storage.setup(getIt);

  auth.setup(getIt);
}
