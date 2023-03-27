import 'dart:async';

import '/src/core/service/service_root.dart';
import '/src/core/data/repository_root.dart';
import '/src/core/ui/page_presenter_base.dart';

part 'vault_secret_controller.dart';
part 'vault_guardian_controller.dart';

typedef Callback = void Function(MessageModel message);

abstract class VaultControllerBase extends PagePresenterBase {
  final serviceRoot = GetIt.I<ServiceRoot>();
  final repositoryRoot = GetIt.I<RepositoryRoot>();

  late final myPeerId = PeerId(
    token: serviceRoot.networkService.myId,
    name: repositoryRoot.settingsRepository.deviceName,
  );
  late final networkSubscription =
      serviceRoot.networkService.messageStream.listen(null);

  Timer? timer;

  VaultControllerBase({required super.pages, super.currentPage});

  bool get isWaiting => timer?.isActive == true;

  @override
  void dispose() {
    timer?.cancel();
    networkSubscription.cancel();
    serviceRoot.platformService.wakelockDisable();
    super.dispose();
  }

  void stopListenResponse() {
    timer?.cancel();
    serviceRoot.platformService.wakelockDisable();
    notifyListeners();
  }

  void startNetworkRequest(void Function([Timer?]) callback) async {
    await serviceRoot.platformService.wakelockEnable();
    timer = Timer.periodic(
      serviceRoot.networkService.router.messageTTL,
      callback,
    );
    callback();
    notifyListeners();
  }

  Future<void> sendToGuardian(final MessageModel message) =>
      serviceRoot.networkService.sendTo(
        isConfirmable: false,
        peerId: message.peerId,
        message: message.copyWith(peerId: myPeerId),
      );

  VaultModel? getGroupById(final VaultId groupId) =>
      repositoryRoot.vaultRepository.get(groupId.asKey);

  Future<VaultModel> createGroup(final VaultModel group) async {
    await repositoryRoot.vaultRepository.put(group.aKey, group);
    notifyListeners();
    return group;
  }

  Future<VaultModel> addGuardian(
    final VaultId groupId,
    final PeerId guardian,
  ) async {
    var group = repositoryRoot.vaultRepository.get(groupId.asKey)!;
    group = group.copyWith(
      guardians: {...group.guardians, guardian: ''},
    );
    await repositoryRoot.vaultRepository.put(groupId.asKey, group);
    return group;
  }
}