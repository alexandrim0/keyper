import 'package:guardian_keyper/ui/widgets/common.dart';

import 'package:guardian_keyper/feature/message/domain/use_case/message_interactor.dart';
import 'package:guardian_keyper/feature/message/ui/dialogs/on_qr_code_show_dialog.dart';
import 'package:guardian_keyper/feature/vault/domain/use_case/vault_interactor.dart';

import 'shards_list_tile.dart';
import '../dialogs/on_vault_transfer_dialog.dart';

class ShardsList extends StatelessWidget {
  const ShardsList({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final vaultInteractor = GetIt.I<VaultInteractor>();

    return StreamBuilder<Object>(
      stream: vaultInteractor.watch(),
      builder: (context, _) {
        final shards = vaultInteractor.shards.toList();
        return Padding(
          padding: paddingAllDefault,
          child: Column(
            crossAxisAlignment: .stretch,
            children: [
              Expanded(
                child: shards.isEmpty
                    ? const Center(
                        child: PageTitle(
                          title: 'Shards will appear here',
                          subtitle:
                              'Shards you are guarding will be displayed here. Each shard is a secure '
                              'component of someone else`s Secret, essential for collective recovery, '
                              'yet individually reveals no information.',
                        ),
                      )
                    : ListView.separated(
                        itemCount: shards.length,
                        itemBuilder: (_, index) =>
                            ShardsListTile(vault: shards[index]),
                        separatorBuilder: (_, _) =>
                            const Padding(padding: paddingT12),
                      ),
              ),

              //Buttons
              const Padding(padding: paddingTDefault),
              Row(
                mainAxisAlignment: .spaceAround,
                children: [
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.shield,
                          size: 48,
                          color: theme.colorScheme.primary,
                        ),
                        padding: EdgeInsets.zero,
                        onPressed: () async {
                          final message = await GetIt.I<MessageInteractor>()
                              .createJoinVaultCode();
                          if (context.mounted) {
                            OnQRCodeShowDialog.show(
                              context,
                              message: message,
                              caption: 'Become a Guardian',
                              title: 'Guardian QR code',
                              subtitle:
                                  'To become a Guardian, show the QR code below to the '
                                  'Safe Owner. If sharing the QR code is not possible, '
                                  'share the text-code instead.',
                            );
                          }
                        },
                      ),
                      const Padding(
                        padding: paddingT12,
                        child: Text('Become a Guardian'),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.auto_awesome_outlined,
                          size: 48,
                          color: theme.colorScheme.primary,
                        ),
                        padding: EdgeInsets.zero,
                        onPressed: () => OnVaultTransferDialog.show(
                          context,
                          vaults: vaultInteractor.shards,
                        ),
                      ),
                      const Padding(
                        padding: paddingT12,
                        child: Text('Help Restore a Safe'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
