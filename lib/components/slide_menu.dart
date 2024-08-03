import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../model/rive_asset.dart';
import '../rive_utils.dart';
import 'info_card.dart';
import 'slide_menu_tile.dart';

class SlideMenu extends StatefulWidget {
  const SlideMenu({super.key});

  @override
  State<SlideMenu> createState() => _SlideMenuState();
}

class _SlideMenuState extends State<SlideMenu> {
  RiveAssets selectedMenu = slideMenus.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: 288,
        color: const Color(0xFF17203A),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const InfoCard(
                name: 'Aly',
                profession: 'YouTuber',
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                child: Text(
                  'Brower'.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white70),
                ),
              ),
              ...slideMenus.map((menu) => SlideMenuTile(
                    menu: menu,
                    riveonInit: (artboard) {
                      StateMachineController controller =
                          RiveUtils.getRiveController(artboard,
                              stateMachineName: menu.stateMachineName);
                      menu.input = controller.findSMI('active') as SMIBool;
                    },
                    press: () {
                      menu.input!.change(true);
                      Future.delayed(const Duration(seconds: 1), () {
                        menu.input!.change(false);
                      });
                      setState(() {
                        selectedMenu = menu;
                      });
                    },
                    isActive: selectedMenu == menu,
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                child: Text(
                  'History'.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white70),
                ),
              ),
              ...sideMenu2.map((menu) => SlideMenuTile(
                    menu: menu,
                    riveonInit: (artboard) {
                      StateMachineController controller =
                          RiveUtils.getRiveController(artboard,
                              stateMachineName: menu.stateMachineName);
                      menu.input = controller.findSMI('active') as SMIBool;
                    },
                    press: () {
                      menu.input!.change(true);
                      Future.delayed(const Duration(seconds: 1), () {
                        menu.input!.change(false);
                      });
                      setState(() {
                        selectedMenu = menu;
                      });
                    },
                    isActive: selectedMenu == menu,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
