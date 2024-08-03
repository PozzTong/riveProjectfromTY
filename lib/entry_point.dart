import 'dart:math';
import 'package:flutter/material.dart';
import 'package:onyoutube/components/animated_bar.dart';
import 'package:onyoutube/components/slide_menu.dart';
import 'package:onyoutube/constants.dart';
import 'package:onyoutube/model/menu_btn.dart';
import 'package:onyoutube/model/rive_asset.dart';
import 'package:onyoutube/rive_utils.dart';
import 'package:onyoutube/screen/home/home_screen.dart';
// import 'package:onyoutube/utils/rive_utils.dart';
import 'package:rive/rive.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint>
    with SingleTickerProviderStateMixin {
  RiveAssets selectedBottomNav = bottomNavs.first;

  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> scalAnimation;

  late SMIBool isSlideBarClosed;
  bool isSlideMenuClosed = true;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(() {
        setState(() {});
      });
    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    scalAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor2,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Stack(
        children: [
          AnimatedPositioned(
            width: 288,
            left: isSlideMenuClosed ? -288 : 0,
            height: MediaQuery.of(context).size.height,
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            child: const SlideMenu(),
          ),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(animation.value - 30 * animation.value * pi / 180),
            child: Transform.translate(
                offset: Offset(animation.value * 265, 0),
                // offset: Offset(288,0),
                child: Transform.scale(
                    scale: scalAnimation.value,
                    child: const ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                        child: HomeScreen()))),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            top: 16,
            left: isSlideMenuClosed ? 0:220,
            child: MenuBtn(
              riveOnInit: (artboard) {
                StateMachineController controller = RiveUtils.getRiveController(
                  artboard,
                  stateMachineName: 'State Machine',
                );
                isSlideBarClosed = controller.findSMI('isOpen') as SMIBool;
                isSlideBarClosed.value = true;
              },
              press: () {
                isSlideBarClosed.value = !isSlideBarClosed.value;
                if (isSlideMenuClosed) {
                  _animationController.forward();
                } else {
                  _animationController.reverse();
                }
                setState(() {
                  isSlideMenuClosed = isSlideBarClosed.value;
                });
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: Transform.translate(
        offset: Offset(0, 100*animation.value),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(12.0),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
                color: backgroundColor2.withOpacity(0.8),
                borderRadius: const BorderRadius.all(Radius.circular(24))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...List.generate(
                    bottomNavs.length,
                    (index) => GestureDetector(
                          onTap: () {
                            if (bottomNavs[index].input != null) {
                              bottomNavs[index].input!.change(true);
                              if (bottomNavs[index] != selectedBottomNav) {
                                setState(() {
                                  selectedBottomNav = bottomNavs[index];
                                });
                              }
                              Future.delayed(const Duration(seconds: 1), () {
                                bottomNavs[index].input!.change(false);
                              });
                            }
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AnimateBar(
                                  isActive: bottomNavs[index] == selectedBottomNav),
                              SizedBox(
                                  height: 36,
                                  width: 36,
                                  child: Opacity(
                                    opacity: bottomNavs[index] == selectedBottomNav
                                        ? 1
                                        : 0.5,
                                    child: RiveAnimation.asset(
                                      bottomNavs.first.scr,
                                      artboard: bottomNavs[index].artboard,
                                      onInit: (artboard) {
                                        StateMachineController? controller =
                                            RiveUtils.getRiveController(artboard,
                                                stateMachineName: bottomNavs[index]
                                                    .stateMachineName);
                                        var input =
                                            controller.findSMI('active') as SMIBool;
                                        if (bottomNavs[index].input == null) {
                                          bottomNavs[index].input = input;
                                        }
                                      },
                                    ),
                                  )),
                            ],
                          ),
                        ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
