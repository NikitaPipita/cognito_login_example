import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:cognito_login_example/spine/gate_way/key_storage.dart';

class SharedPreferenceStorageGateWay implements KeyStorageGateWay {
  static const _isFirstRun = 'first_run';

  final _asyncSharedPreferences = Completer<SharedPreferences>();

  SharedPreferenceStorageGateWay() {
    _init();
  }

  void _init() async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      _asyncSharedPreferences.complete(sharedPreferences);
    } catch (e, s) {
      _asyncSharedPreferences.completeError(e, s);
    }
  }

  @override
  Future<bool> isFirstRun() async {
    final sharedPreferences = await _asyncSharedPreferences.future;
    final firstRun = sharedPreferences.getBool(_isFirstRun) ?? true;
    if (firstRun) {
      await sharedPreferences.setBool(_isFirstRun, false);
    }
    return firstRun;
  }
}
