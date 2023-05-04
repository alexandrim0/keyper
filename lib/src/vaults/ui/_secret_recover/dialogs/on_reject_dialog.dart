import 'package:guardian_keyper/src/core/ui/widgets/emoji.dart';
import 'package:guardian_keyper/src/core/ui/widgets/common.dart';
import 'package:guardian_keyper/src/core/ui/widgets/icon_of.dart';
import 'package:guardian_keyper/src/message/domain/message_model.dart';

class OnRejectDialog extends StatelessWidget {
  static Future<void> show(
    final BuildContext context,
    final MessageModel message,
  ) =>
      showModalBottomSheet(
        context: context,
        isDismissible: true,
        isScrollControlled: true,
        builder: (_) => OnRejectDialog(message: message),
      );

  const OnRejectDialog({super.key, required this.message});

  final MessageModel message;

  @override
  Widget build(final BuildContext context) => BottomSheetWidget(
        icon: const IconOf.secretRestoration(
          isBig: true,
          bage: BageType.error,
        ),
        titleString: 'Guardian rejected the recovery of your Secret',
        textSpan: buildTextWithId(
          leadingText: 'Secret Recovery process for ',
          id: message.vaultId,
          trailingText: ' has been terminated by your Guardians.',
        ),
        footer: Padding(
          padding: paddingV20,
          child: PrimaryButton(
            text: 'Done',
            onPressed: Navigator.of(context).pop,
          ),
        ),
      );
}
