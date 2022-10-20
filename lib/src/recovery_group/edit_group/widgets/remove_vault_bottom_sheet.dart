import '/src/core/di_container.dart';
import '/src/core/widgets/common.dart';
import '/src/core/widgets/icon_of.dart';
import '/src/core/model/core_model.dart';

class RemoveVaultBottomSheet extends StatelessWidget {
  const RemoveVaultBottomSheet({super.key, required this.group});

  final RecoveryGroupModel group;

  @override
  Widget build(BuildContext context) => BottomSheetWidget(
        footer: ElevatedButton(
          child: const SizedBox(
            width: double.infinity,
            child: Text(
              'Remove the Vault',
              textAlign: TextAlign.center,
            ),
          ),
          onPressed: () => showModalBottomSheet<Object?>(
            context: context,
            isScrollControlled: true,
            builder: (_) => _RemoveGroupConfirmBottomSheet(group: group),
          ).then(Navigator.of(context).pop),
        ),
      );
}

class _RemoveGroupConfirmBottomSheet extends StatelessWidget {
  final RecoveryGroupModel group;

  const _RemoveGroupConfirmBottomSheet({required this.group});

  @override
  Widget build(BuildContext context) => BottomSheetWidget(
        icon: const IconOf.removeGroup(isBig: true, bage: BageType.warning),
        titleString: 'Do you want to remove this Vault?',
        textString: 'All the Secrets from this Vault will be removed as well.',
        footer: SizedBox(
          width: double.infinity,
          child: PrimaryButton(
            text: 'Yes, remove the Vault',
            onPressed: () => context
                .read<DIContainer>()
                .boxRecoveryGroups
                .delete(group.aKey)
                .then(
                  (_) => Navigator.of(context).popUntil(
                    ModalRoute.withName('/recovery_group/edit'),
                  ),
                ),
          ),
        ),
      );
}