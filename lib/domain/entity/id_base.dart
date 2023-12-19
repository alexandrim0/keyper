import 'dart:math';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:collection/collection.dart';

import 'package:guardian_keyper/consts.dart';

import 'serializable.dart';

@immutable
abstract class IdBase extends Serializable {
  static const _listEq = ListEquality<int>();

  static final _random = Random.secure();

  static Uint8List getNewToken({int length = 8}) =>
      Uint8List.fromList(Iterable.generate(
        length,
        (x) => _random.nextInt(255),
      ).toList());

  IdBase({
    required this.token,
    this.name = '',
  });

  final String name;
  final Uint8List token;

  late final asHex = _asHex();
  late final asKey = base64UrlEncode(token);
  late final tokenEmojiByte = token.fold(0, (v, e) => v ^ e);

  @override
  bool operator ==(Object other) =>
      other is IdBase &&
      runtimeType == other.runtimeType &&
      _listEq.equals(token, other.token);

  @override
  int get hashCode => Object.hash(runtimeType, _listEq.hash(token));

  @override
  String toString() => asKey;

  String toHexShort([int count = shortKeyLength]) => asHex.length > count * 2
      ? '0x${asHex.substring(0, count)}...${asHex.substring(asHex.length - count)}'
      : '0x$asHex';

  String _asHex() {
    final buffer = StringBuffer();
    for (final byte in token) {
      buffer.write(byte.toRadixString(16).padLeft(2, '0'));
    }
    return buffer.toString();
  }
}
