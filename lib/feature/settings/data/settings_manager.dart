import 'dart:async';
import 'package:get_it/get_it.dart';

import 'package:guardian_keyper/domain/entity/_id/peer_id.dart';
import 'package:guardian_keyper/data/network_manager.dart';
import 'package:guardian_keyper/data/platform_service.dart';
import 'package:guardian_keyper/data/preferences_service.dart';

class SettingsManager {
  PeerId get selfId => _selfId;
  String get passCode => _passCode;
  String get deviceName => _deviceName;
  bool get hasBiometrics => _hasBiometrics;
  bool get isBootstrapEnabled => _isBootstrapEnabled;
  bool get isBiometricsEnabled => _isBiometricsEnabled;
  Stream<(String, Object)> get changes => _updatesStreamController.stream;

  final _platformManager = GetIt.I<PlatformService>();
  final _preferencesManager = GetIt.I<PreferencesService>();
  final _updatesStreamController =
      StreamController<(String, Object)>.broadcast();

  late PeerId _selfId;
  late String _passCode, _deviceName;
  late bool _isBiometricsEnabled, _isBootstrapEnabled, _hasBiometrics;

  Future<SettingsManager> init() async {
    _passCode = await _preferencesManager.get<String>(keyPassCode) ?? '';
    _isBootstrapEnabled =
        await _preferencesManager.get<bool>(keyIsBootstrapEnabled) ?? true;
    _isBiometricsEnabled =
        await _preferencesManager.get<bool>(keyIsBiometricsEnabled) ?? true;
    _deviceName = await _preferencesManager.get<String>(keyDeviceName) ??
        await _platformManager.getDeviceName();
    _selfId = PeerId(
      token: GetIt.I<NetworkManager>().selfId,
      name: _deviceName,
    );

    await getHasBiometrics();
    return this;
  }

  Future<bool> getHasBiometrics() => _platformManager
      .getAvailableBiometrics()
      .then((value) => _hasBiometrics = value.isNotEmpty);

  Future<void> setDeviceName(final String value) async {
    _deviceName = value;
    _selfId = _selfId.copyWith(name: value);
    await _preferencesManager.set<String>(keyDeviceName, value);
    _updatesStreamController.add((keyDeviceName, value));
  }

  Future<void> setPassCode(final String value) async {
    _passCode = value;
    await _preferencesManager.set<String>(keyPassCode, value);
    _updatesStreamController.add((keyPassCode, value));
  }

  Future<void> setIsBootstrapEnabled(final bool value) async {
    _isBootstrapEnabled = value;
    await _preferencesManager.set<bool>(keyIsBootstrapEnabled, value);
    _updatesStreamController.add((keyIsBootstrapEnabled, value));
  }

  Future<void> setIsBiometricsEnabled(final bool value) async {
    _isBiometricsEnabled = value;
    await _preferencesManager.set<bool>(keyIsBiometricsEnabled, value);
    _updatesStreamController.add((keyIsBiometricsEnabled, value));
  }
}
