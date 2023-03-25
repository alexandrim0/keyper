import '/src/core/ui/widgets/common.dart';

import '../intro_controller.dart';

class SetPasscodePage extends StatefulWidget {
  const SetPasscodePage({super.key});

  @override
  State<SetPasscodePage> createState() => _SetPasscodePageState();
}

class _SetPasscodePageState extends State<SetPasscodePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<IntroController>().createPassCode(context: context),
    );
  }

  @override
  Widget build(final BuildContext context) =>
      Container(color: Theme.of(context).colorScheme.background);
}
