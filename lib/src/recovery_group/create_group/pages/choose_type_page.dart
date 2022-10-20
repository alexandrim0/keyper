import '/src/core/theme/theme.dart';
import '/src/core/widgets/misc.dart';
import '/src/core/widgets/common.dart';
import '/src/core/widgets/icon_of.dart';

import '../create_group_controller.dart';

class ChooseTypePage extends StatelessWidget {
  static const _textYourDevices = '''
Your devices and devices that belong to your
Guardians, trusted people, friends and family
who act on your behalf when required.
''';

  static const _textFiduciaries = '''
Trusted appointed fiduciary third parties
appointed to act as Guardians on your
behalf on a professional basis.''';

  const ChooseTypePage({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          // Header
          const HeaderBar(
            caption: 'Add a new Vault',
            closeButton: HeaderBarCloseButton(),
          ),
          // Body
          Expanded(
            child: ListView(
              padding: paddingAll20,
              children: [
                // Your Devices
                GestureDetector(
                  onTap: context.read<CreateGroupController>().nextScreen,
                  child: SelectableCard(
                      isSelected: true,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const IconOf.yourDevices(bgColor: clWhite),
                          Padding(
                            padding: paddingTop20,
                            child: Text(
                              'Your Devices',
                              style: textStylePoppins616,
                            ),
                          ),
                          Padding(
                            padding: paddingTop12,
                            child: Text(
                              _textYourDevices,
                              style: textStyleSourceSansPro414Purple,
                            ),
                          ),
                        ],
                      )),
                ),
                const Padding(padding: paddingTop20),
                // Fiduciaries
                SelectableCard(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const IconOf.fiduciaries(bgColor: clWhite),
                        Container(
                          height: 28,
                          width: 53,
                          alignment: Alignment.center,
                          decoration: boxDecoration.copyWith(
                            color: clIndigo500,
                          ),
                          child: Text('Soon', style: textStyleSourceSansPro614),
                        ),
                      ],
                    ),
                    Padding(
                      padding: paddingTop20,
                      child: Text('Fiduciaries', style: textStylePoppins616),
                    ),
                    Padding(
                      padding: paddingTop12,
                      child: Text(
                        _textFiduciaries,
                        style: textStyleSourceSansPro414Purple,
                      ),
                    ),
                  ],
                )),
              ],
            ),
          ),
        ],
      );
}