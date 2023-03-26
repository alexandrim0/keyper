import '/src/core/ui/widgets/common.dart';

import '../vault_create_controller.dart';
import '../widgets/vault_size_info_panel.dart';
import '../widgets/guardians_control_panel.dart';

class ChooseSizePage extends StatelessWidget {
  const ChooseSizePage({super.key});

  @override
  Widget build(final BuildContext context) => Column(children: [
        // Header
        HeaderBar(
          caption: 'Vault Size',
          backButton: HeaderBarBackButton(
            onPressed: context.read<VaultCreateController>().previousScreen,
          ),
          closeButton: const HeaderBarCloseButton(),
        ),
        // Body
        Expanded(
          child: ListView(
            padding: paddingAll20,
            children: [
              Padding(
                padding: paddingBottom20,
                child: Text(
                  'Select Guardians amount',
                  style: textStylePoppins620,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: paddingBottom32,
                child: Text(
                  'Pick amount of Guardians which will be responsible '
                  'for keeping the Shards (parts) of your Secrets.',
                  style: textStyleSourceSansPro416,
                  textAlign: TextAlign.center,
                ),
              ),
              // Control
              const GuardiansControlPanel(),
              // Info
              Padding(
                padding: paddingTop32,
                child: Consumer<VaultCreateController>(
                  builder: (_, controller, __) => VaultSizeInfoPanel(
                    key: Key(DateTime.now().toIso8601String()),
                    atLeast: controller.isGroupMember
                        ? controller.groupSize - 1
                        : controller.groupSize,
                    ofAmount: controller.isGroupMember
                        ? controller.groupThreshold - 1
                        : controller.groupThreshold,
                  ),
                ),
              ),
              // Footer
              Padding(
                padding: paddingV32,
                child: PrimaryButton(
                  text: 'Continue',
                  onPressed: context.read<VaultCreateController>().nextScreen,
                ),
              ),
            ],
          ),
        ),
      ]);
}