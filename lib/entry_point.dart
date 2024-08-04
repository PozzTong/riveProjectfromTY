import 'dart:math';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'components/animated_bar.dart';
import 'components/slide_menu.dart';
import 'constants.dart';
import 'model/menu_btn.dart';
import 'model/rive_asset.dart';
import 'model/rive_utils.dart';
import 'screen/home/home_screen.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint>
    with SingleTickerProviderStateMixin {
  RiveAssets selectedBottomNav = bottomNavs.first;
  int _currentIndex = 0;
  final PageController _pageController = PageController();

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
    _pageController.dispose();
    super.dispose();
  }

  void _onNavItemTapped(int index) {
    if (bottomNavs[index].input != null) {
      bottomNavs[index].input!.change(true);
      if (bottomNavs[index] != selectedBottomNav) {
        setState(() {
          _currentIndex = index;
          selectedBottomNav = bottomNavs[index];
        });
        _pageController.jumpToPage(index);
      }
      Future.delayed(const Duration(seconds: 1), () {
        bottomNavs[index].input!.change(false);
      });
    }
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
                child: Transform.scale(
                    scale: scalAnimation.value,
                    child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(24)),
                        child: PageView(
                          controller: _pageController,
                          children: const [
                            HomeScreen(),
                            PageOne(),
                            PageTwo(),
                            PageThree(),
                            PageFour()
                          ],
                          onPageChanged: (index) {
                            setState(() {
                              _currentIndex = index;
                              selectedBottomNav = bottomNavs[index];
                            });
                          },
                        ))),
              )),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            top: 16,
            left: isSlideMenuClosed ? 0 : 220,
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
        offset: Offset(0, 100 * animation.value),
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
                          onTap: () => _onNavItemTapped(index),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              // color: index == _currentIndex
                              //     ? Colors.blue.withOpacity(0.1)
                              //     : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AnimateBar(isActive: index == _currentIndex),
                                SizedBox(
                                    height: 36,
                                    width: 36,
                                    child: Opacity(
                                      opacity: index == _currentIndex ? 1 : 0.5,
                                      child: RiveAnimation.asset(
                                        bottomNavs.first.scr,
                                        artboard: bottomNavs[index].artboard,
                                        onInit: (artboard) {
                                          StateMachineController? controller =
                                              RiveUtils.getRiveController(
                                                  artboard,
                                                  stateMachineName:
                                                      bottomNavs[index]
                                                          .stateMachineName);
                                          var input = controller
                                              .findSMI('active') as SMIBool;
                                          if (bottomNavs[index].input == null) {
                                            bottomNavs[index].input = input;
                                          }
                                        },
                                      ),
                                    )),
                              ],
                            ),
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

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page One')),
      body: const Center(child: Text('This is Page One')),
    );
  }
}

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page Two')),
      body: const Center(child: Text('This is Page Two')),
    );
  }
}

class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page Three')),
      body: const Center(child: Text('This is Page Three')),
    );
  }
}

class PageFour extends StatelessWidget {
  const PageFour({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page Four')),
      body: const Center(child: Text('This is Page Four')),
    );
  }
}
