import 'package:double_back_to_close_app/double_back_to_close_app.dart';

import '/src/core/consts.dart';
import '/src/core/di_container.dart';
import '/src/core/model/core_model.dart';
import '/src/core/widgets/common.dart';
import '/src/core/widgets/icon_of.dart';

import '/src/guardian/pages/message_page.dart';
import '/src/guardian/widgets/message_list_tile.dart';

import 'home_controller.dart';
import 'pages/dashboard_page.dart';
import 'pages/shards_page.dart';
import 'pages/vaults_page.dart';
import 'widgets/notification_icon.dart';

class HomeView extends StatefulWidget {
  static const routeName = routeHome;

  static const _pages = [
    DashboardPage(),
    VaultsPage(),
    ShardsPage(),
    MessagesPage(),
  ];

  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final _diContainer = context.read<DIContainer>();

  @override
  void initState() {
    super.initState();
    _diContainer.boxMessages.watch().listen(
      (event) async {
        if (ModalRoute.of(context)?.isCurrent != true) return;
        if (event.deleted) return;
        final message = event.value as MessageModel;
        if (message.isNotReceived) return;
        await MessageListTile.showActiveMessage(context, message);
      },
    );
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => HomeController(
          pages: HomeView._pages,
          diContainer: _diContainer,
        ),
        child: Selector<HomeController, int>(
          selector: (_, controller) => controller.currentPage,
          builder: (context, currentPage, __) => ScaffoldWidget(
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: currentPage,
              items: const [
                BottomNavigationBarItem(
                  icon: IconOf.navBarHome(),
                  activeIcon: IconOf.navBarHomeSelected(),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: IconOf.navBarKey(),
                  activeIcon: IconOf.navBarKeySelected(),
                  label: 'Vaults',
                ),
                BottomNavigationBarItem(
                  icon: IconOf.navBarShield(),
                  activeIcon: IconOf.navBarShieldSelected(),
                  label: 'Shards',
                ),
                BottomNavigationBarItem(
                  icon: MessagesIcon(),
                  activeIcon: MessagesIcon.selected(),
                  label: 'Messages',
                ),
              ],
              onTap: (value) =>
                  context.read<HomeController>().gotoScreen(value),
            ),
            child: DoubleBackToCloseApp(
              snackBar: const SnackBar(content: Text('Tap back again to exit')),
              child: HomeView._pages[currentPage],
            ),
          ),
        ),
      );
}
