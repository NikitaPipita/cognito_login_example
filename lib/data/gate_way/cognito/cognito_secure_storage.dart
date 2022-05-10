import 'dart:async';

import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:cognito_login_example/spine/gate_way/key_storage.dart';

class CognitoSecureStorageGateWay implements CognitoStorage {
  static const _keyPrefix = 'Cognito-';

  final Completer<FlutterSecureStorage> _asyncSecureStorage;
  final KeyStorageGateWay _keyStorageGateWay;

  CognitoSecureStorageGateWay(this._keyStorageGateWay)
      : _asyncSecureStorage = Completer<FlutterSecureStorage>() {
    _isFirstRun();
  }

  Future<void> _isFirstRun() async {
    try {
      final firstRun = await _keyStorageGateWay.isFirstRun();
      const secureStorage = FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true),
      );
      if (firstRun) {
        await secureStorage.deleteAll();
      }
      _asyncSecureStorage.complete(secureStorage);
    } catch (e, s) {
      _asyncSecureStorage.completeError(e, s);
    }
  }

  @override
  Future<dynamic> setItem(String key, dynamic value) async {
    final secureStorage = await _asyncSecureStorage.future;
    final secureKey = _keyPrefix + key;
    await secureStorage.write(key: secureKey, value: value);
    return secureStorage.read(key: secureKey);
  }

  @override
  Future<dynamic> removeItem(String key) async {
    final secureStorage = await _asyncSecureStorage.future;
    final secureKey = _keyPrefix + key;
    final removedValue = secureStorage.read(key: secureKey);
    await secureStorage.delete(key: secureKey);
    return removedValue;
  }

  @override
  Future<dynamic> getItem(String key) async {
    final secureStorage = await _asyncSecureStorage.future;
    final secureKey = _keyPrefix + key;
    return secureStorage.read(key: secureKey);
  }

  @override
  Future<void> clear() async {
    final secureStorage = await _asyncSecureStorage.future;
    final values = await secureStorage.readAll();
    final valuesToRemove =
        values.entries.where((element) => element.key.startsWith(_keyPrefix));
    await Future.wait([
      for (final mapEntry in valuesToRemove)
        secureStorage.delete(key: mapEntry.key),
    ]);
  }
}
