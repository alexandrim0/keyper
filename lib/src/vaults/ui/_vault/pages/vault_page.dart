import 'package:guardian_keyper/src/core/consts.dart';
import 'package:guardian_keyper/src/core/ui/widgets/common.dart';

import '../presenters/vault_presenter.dart';
import '../widgets/secrets_panel_list.dart';
import '../widgets/guardians_expansion_tile.dart';

class VaultPage extends StatelessWidget {
  const VaultPage({super.key});

  @override
  Widget build(final BuildContext context) {
    final vault = context.read<VaultPresenter>().vault;
    return ListView(
      padding: paddingAll20,
      primary: true,
      shrinkWrap: true,
      children: [
        // Title
        vault.hasSecrets
            ? const PageTitle(
                title: 'The Vault is ready to use',
                subtitle:
                    'Add and recover Secrets with the help of your Guaridans.',
              )
            : PageTitle(
                title: 'Add your Secret',
                subtitle: 'In order to restore your Secret in the future '
                    'you’d have to get an approval from at least '
                    '${vault.threshold} Guardians of this Vault.',
              ),
        // Action Button
        Padding(
          padding: paddingBottom32,
          child: PrimaryButton(
            text: 'Add a Secret',
            onPressed: () => Navigator.of(context).pushNamed(
              routeVaultAddSecret,
              arguments: vault.id,
            ),
          ),
        ),
        // Guardians
        const GuardiansExpansionTile(),
        // Secrets
        if (vault.hasSecrets)
          Padding(
            padding: paddingV20,
            child: Text(
              'Secrets',
              style: textStylePoppins620,
            ),
          ),
        if (vault.hasSecrets) const SecretsPanelList(),
      ],
    );
  }
}
