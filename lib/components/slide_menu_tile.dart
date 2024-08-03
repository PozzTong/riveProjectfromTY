import 'package:flutter/material.dart';
import 'package:onyoutube/model/rive_asset.dart';
import 'package:rive/rive.dart';

class SlideMenuTile extends StatelessWidget {
  const SlideMenuTile({
    super.key,
    required this.menu,
    required this.press,
    required this.riveonInit,
    required this.isActive,
  });
  final RiveAssets menu;
  final VoidCallback press;
  final ValueChanged<Artboard> riveonInit;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 24),
          child: Divider(
            color: Colors.white24,
            height: 1,
          ),
        ),
        Stack(
          children: [
            AnimatedPositioned(
              curve: Curves.fastOutSlowIn,
              height: 56,
              width: isActive ? 288 : 0,
              left: 0,
              duration: const Duration(milliseconds: 300),
              child: Container(
                decoration: const BoxDecoration(
                    color: Color(0xFF6792FF),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
            // : SizedBox(),
            ListTile(
              onTap: press,
              leading: SizedBox(
                height: 34,
                width: 34,
                child: RiveAnimation.asset(
                  menu.scr,
                  artboard: menu.artboard,
                  onInit: riveonInit,
                ),
              ),
              title: Text(menu.title),
              textColor: Colors.white,
            ),
          ],
        ),
      ],
    );
  }
}
