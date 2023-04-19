import 'dart:typed_data';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:guardian_keyper/src/core/data/preferences_manager.dart';

import '../domain/vault_model.dart';

typedef VaultRepository = Box<VaultModel>;

Future<VaultRepository> getVaultRepository() async {
  Hive.registerAdapter<VaultModel>(VaultModelAdapter());
  final cipher = HiveAesCipher(
      await GetIt.I<PreferencesManager>().get<Uint8List>(keySeed) ??
          Uint8List(0));
  return Hive.openBox<VaultModel>('vaults', encryptionCipher: cipher);
}

class VaultModelAdapter extends TypeAdapter<VaultModel> {
  @override
  final typeId = VaultModel.typeId;

  @override
  VaultModel read(BinaryReader reader) =>
      VaultModel.fromBytes(reader.readByteList());

  @override
  void write(BinaryWriter writer, VaultModel obj) =>
      writer.writeByteList(obj.toBytes());
}
