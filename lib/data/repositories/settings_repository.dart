import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
export 'package:get_it/get_it.dart';

export 'package:guardian_keyper/data/enums.dart';
import 'package:guardian_keyper/data/enums.dart';

typedef SettingsRepositoryEvent<T extends Object> = ({
  PreferencesKeys key,
  T? value,
});

class SettingsRepository {
  final _cache = <PreferencesKeys, String?>{};

  final _events = StreamController<SettingsRepositoryEvent>.broadcast();

  Future<SettingsRepository> init(String pathAppDir) async {
    await _cacheValues();
    return this;
  }

  T? get<T extends Object>(PreferencesKeys key, [T? defaultValue]) {
    final value = _cache[key];
    return value == null
        ? defaultValue
        : switch (_typeOf<T>()) {
            _ when T is String => value as T,
            _ when T is int => int.parse(value) as T,
            _ when T is bool => bool.parse(value) as T,
            _ when T is Uint8List => base64Decode(value) as T,
            _ => throw const PreferencesValueFormatException(),
          };
  }

  Future<T> set<T extends Object>(PreferencesKeys key, T value) async {
    late final String valueString;
    switch (value) {
      case int() || bool() || String():
        valueString = value.toString();
        await _storage.write(
          key: key.name,
          value: valueString,
          iOptions: _iOptions,
        );
      case Uint8List():
        valueString = base64UrlEncode(value as Uint8List);
        await _storage.write(
          key: key.name,
          value: valueString,
        );
      default:
        throw const PreferencesValueFormatException();
    }
    _cache[key] = valueString;
    _events.add((key: key, value: value));
    return value;
  }

  Future<T?> setNullable<T extends Object>(
    PreferencesKeys key,
    T? value,
  ) async {
    if (value == null) {
      await delete(key);
      return value;
    } else {
      return set(key, value);
    }
  }

  Future<void> delete(PreferencesKeys key) async {
    _cache.remove(key);
    await _storage.delete(key: key.name);
    _events.add((key: key, value: null));
  }

  Stream<SettingsRepositoryEvent<T>> watch<T extends Object>([
    PreferencesKeys? key,
  ]) {
    final stream = key == null
        ? _events.stream
        : _events.stream.where((e) => e.key == key);
    return stream.map<SettingsRepositoryEvent<T>>(
      (e) => (
        key: e.key,
        value: e.value as T?,
      ),
    );
  }

  Future<void> _cacheValues() async {
    for (final key in PreferencesKeys.values) {
      _cache[key] = await _storage.read(
        key: key.name,
        iOptions: _iOptions,
      );
    }
  }

  static const _iOptions = IOSOptions(
    accessibility: KeychainAccessibility.first_unlock_this_device,
  );
  static const _storage = FlutterSecureStorage(
    iOptions: _iOptions,
  );

  static Type _typeOf<X>() => X;
}

class PreferencesValueFormatException extends FormatException {
  const PreferencesValueFormatException() : super('Unsupported value type');
}
