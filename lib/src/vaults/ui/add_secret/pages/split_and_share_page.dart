import '/src/core/ui/widgets/common.dart';

import '../vault_add_secret_presenter.dart';
import '../widgets/add_secret_close_button.dart';
import '../../widgets/guardian_self_list_tile.dart';
import '../../widgets/guardian_list_tile.dart';

class SplitAndShareSecretPage extends StatelessWidget {
  const SplitAndShareSecretPage({super.key});

  @override
  Widget build(final BuildContext context) {
    final controller = context.read<VaultAddSecretPresenter>();
    return Column(
      children: [
        // Header
        HeaderBar(
          caption: 'Split Secret',
          backButton: HeaderBarBackButton(
            onPressed: controller.previousScreen,
          ),
          closeButton: const AddSecretCloseButton(),
        ),
        // Body
        Expanded(
          child: ListView(
            padding: paddingH20,
            primary: true,
            shrinkWrap: true,
            children: [
              PageTitle(
                title: 'Split and share Secret with Guardians below',
                subtitleSpans: [
                  const TextSpan(
                    text: 'You are about to split your Secret in ',
                  ),
                  TextSpan(
                    text: '${controller.vault.maxSize} encrypted Shards.',
                  ),
                  const TextSpan(
                    text: ' Each Guardian will receieve their own'
                        ' Shard which can be used to restore your Secret.',
                  ),
                ],
              ),
              Column(children: [
                for (final guardian in controller.vault.guardians.keys)
                  Padding(
                    padding: paddingV6,
                    child: guardian == controller.vault.ownerId
                        ? GuardianSelfListTile(guardian: guardian)
                        : GuardianListTile(guardian: guardian),
                  )
              ]),
              // Footer
              Padding(
                padding: paddingV32,
                child: PrimaryButton(
                  text: 'Continue',
                  onPressed: controller.nextScreen,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
