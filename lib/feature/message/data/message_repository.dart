import 'dart:typed_data';
import 'package:hive/hive.dart';
import 'package:get_it/get_it.dart';

import 'package:guardian_keyper/data/services/preferences_service.dart';
import 'package:guardian_keyper/feature/message/domain/entity/message_model.dart';

/// Depends on [PreferencesService]
class MessageRepository {
  late final flush = _storage.flush;

  late final Box<MessageModel> _storage;

  Iterable<MessageModel> get values => _storage.values;

  Future<MessageRepository> init() async {
    final preferences = GetIt.I<PreferencesService>();
    Hive.init(preferences.pathDataDir);
    final seed = await preferences.get<Uint8List>(PreferencesKeys.keySeed);
    Hive.registerAdapter<MessageModel>(MessageModelAdapter());
    _storage = await Hive.openBox<MessageModel>(
      'messages',
      encryptionCipher: HiveAesCipher(seed!),
    );
    return this;
  }

  MessageModel? get(String key) => _storage.get(key);

  bool containsKey(String key) => _storage.containsKey(key);

  Future<void> put(String key, MessageModel value) => _storage.put(key, value);

  Future<void> delete(String key) => _storage.delete(key);

  Stream<({String key, MessageModel? message, bool isDeleted})> watch([
    String? key,
  ]) =>
      _storage.watch(key: key).map((e) => (
            key: e.key as String,
            message: e.value as MessageModel?,
            isDeleted: e.deleted,
          ));

  Future<void> prune() async {
    await _storage.deleteAll(
        _storage.values.where((e) => e.isForPrune).map((e) => e.aKey));
    await _storage.compact();
  }
}

class MessageModelAdapter extends TypeAdapter<MessageModel> {
  @override
  final typeId = MessageModel.typeId;

  @override
  MessageModel read(BinaryReader reader) =>
      MessageModel.fromBytes(reader.readByteList());

  @override
  void write(BinaryWriter writer, MessageModel obj) =>
      writer.writeByteList(obj.toBytes());
}