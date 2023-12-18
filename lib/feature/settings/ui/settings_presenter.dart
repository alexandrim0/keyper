import 'package:get_it/get_it.dart';
import 'package:flutter/widgets.dart';

import 'package:guardian_keyper/consts.dart';
import 'package:guardian_keyper/feature/auth/data/auth_manager.dart';
import 'package:guardian_keyper/feature/network/data/network_manager.dart';

export 'package:provider/provider.dart';

class SettingsPresenter extends ChangeNotifier {
  SettingsPresenter() {
    _authManager.getHasBiometrics().then((hasBiometrics) {
      if (hasBiometrics != _hasBiometrics) {
        _hasBiometrics = hasBiometrics;
        notifyListeners();
      }
    });
  }

  final _authManager = GetIt.I<AuthManager>();
  final _networkManager = GetIt.I<NetworkManager>();

  late String _deviceName = _networkManager.selfId.name;

  bool _hasBiometrics = false;

  bool get hasBiometrics => _hasBiometrics;
  String get deviceName => _networkManager.selfId.name;
  bool get isBiometricsEnabled => _authManager.isBiometricsEnabled;
  bool get isBootstrapEnabled => _networkManager.isBootstrapEnabled;
  bool get hasMinimumDeviceNameLength => _deviceName.length >= minNameLength;

  set deviceName(final String value) {
    _deviceName = value;
    notifyListeners();
  }

  Future<void> setDeviceName() async {
    if (_networkManager.selfId.name == _deviceName) return;
    await _networkManager.setDeviceName(_deviceName);
    notifyListeners();
  }

  Future<void> setIsBootstrapEnabled(final bool value) async {
    await _networkManager.setIsBootstrapEnabled(value);
    notifyListeners();
  }

  Future<void> setIsBiometricsEnabled(final bool value) async {
    await _authManager.setIsBiometricsEnabled(value);
    notifyListeners();
  }
}