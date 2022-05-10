import 'package:cognito_login_example/data/gate_way/shared_preference_storage.dart';
import 'package:cognito_login_example/spine/gate_way/key_storage.dart';
import 'package:get_it/get_it.dart';

void setup(GetIt getIt) {
  getIt.registerLazySingleton<KeyStorageGateWay>(
      () => SharedPreferenceStorageGateWay());
}
