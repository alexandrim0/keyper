import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:messagepack/messagepack.dart';

import '../utils/random_utils.dart';

part 'recovery_group_model.dart';
part 'secret_shard_model.dart';
part 'settings_model.dart';
part 'message_model.dart';
part 'peer_address.dart';
part 'key_bunch.dart';
part 'id_model.dart';

abstract class Serializable extends Equatable {
  const Serializable();

  bool get isEmpty;

  bool get isNotEmpty;

  Uint8List toBytes();

  String toBase64url() => base64UrlEncode(toBytes());
}

@immutable
class Globals {
  final String storageName;
  final String bsAddressV4;
  final String bsAddressV6;
  final int maxNameLength;
  final int minNameLength;
  final int passCodeLength;
  final int maxSecretLength;
  final Duration pageChangeDuration;
  final Duration retryNetworkTimeout;
  final Duration snackBarDuration;
  final Duration qrCodeExpires;

  const Globals({
    this.storageName = 'data',
    this.bsAddressV4 = '',
    this.bsAddressV6 = '',
    this.maxNameLength = 25,
    this.minNameLength = 3,
    this.passCodeLength = 6,
    this.maxSecretLength = 256,
    this.pageChangeDuration = const Duration(milliseconds: 250),
    this.retryNetworkTimeout = const Duration(seconds: 3),
    this.snackBarDuration = const Duration(seconds: 4),
    this.qrCodeExpires = const Duration(days: 1),
  });
}
