import 'package:guardian_keyper/ui/widgets/common.dart';
import 'package:guardian_keyper/feature/vault/data/vault_repository.dart';
import 'package:guardian_keyper/feature/vault/ui/_shard_show/dialogs/on_change_owner_dialog.dart';

class OnVaultTransferDialog extends StatelessWidget {
  static Future<void> show(
    BuildContext context, {
    required Iterable<Vault> vaults,
  }) =>
      Navigator.of(context).push(
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (_) => OnVaultTransferDialog(vaults: vaults),
        ),
      );

  const OnVaultTransferDialog({
    required this.vaults,
    super.key,
  });

  final Iterable<Vault> vaults;

  @override
  Widget build(BuildContext context) => ScaffoldSafe(
        child: Column(
          children: [
            // Header
            const HeaderBar(
              caption: 'Assist with a Vault',
              backButton: HeaderBarBackButton(),
            ),
            // Body
            const Padding(
              padding: paddingAll20,
              child: Text(
                'Select a Vault to assist with its recovery '
                'or ownership transfer.',
                textAlign: TextAlign.center,
              ),
            ),
            // Shards List
            Expanded(
              child: ListView(
                padding: paddingH20,
                children: [
                  for (final vault in vaults)
                    Padding(
                      padding: paddingV6,
                      child: ListTile(
                        title: Text(vault.id.name),
                        subtitle: Text('Owned by ${vault.ownerId.name}'),
                        onTap: () => OnChangeOwnerDialog.show(
                          context,
                          vaultId: vault.id,
                        ),
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      );
}
