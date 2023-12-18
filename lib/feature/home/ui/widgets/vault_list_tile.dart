import 'package:guardian_keyper/consts.dart';
import 'package:guardian_keyper/ui/widgets/common.dart';
import 'package:guardian_keyper/ui/widgets/icon_of.dart';

import 'package:guardian_keyper/feature/vault/domain/entity/vault.dart';

class VaultListTile extends StatelessWidget {
  static const _styleRed = TextStyle(color: clRed);

  const VaultListTile({
    required this.vault,
    super.key,
  });

  final Vault vault;

  @override
  Widget build(BuildContext context) => ListTile(
        leading: const IconOf.shield(color: clWhite),
        title: Text(vault.id.name),
        subtitle: vault.isRestricted
            ? (vault.hasQuorum
                ? const Text('Restricted usage', style: _styleRed)
                : const Text('Complete the Recovery', style: _styleRed))
            : (vault.isFull
                ? Text(
                    '${vault.size} Guardians, ${vault.secrets.length} Secrets',
                  )
                : const Text('Add more Guardians', style: _styleRed)),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          color: clWhite,
        ),
        onTap: () => Navigator.pushNamed(
          context,
          routeVaultShow,
          arguments: vault.id,
        ),
      );
}
