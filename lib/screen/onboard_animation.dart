import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:onyoutube/screen/components/animation_btn.dart';
import 'package:onyoutube/screen/components/sign_in_dialog.dart';
import 'package:rive/rive.dart' as rive;

class OnboardAnimation extends StatefulWidget {
  const OnboardAnimation({super.key});

  @override
  State<OnboardAnimation> createState() => _OnboardAnimationState();
}

class _OnboardAnimationState extends State<OnboardAnimation> {
  late rive.RiveAnimationController _btnAnimationController;
  bool isSignInDialogshow = false;

  @override
  void initState() {
    _btnAnimationController = rive.OneShotAnimation(
      "active",
      // autoplay: false
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              width: MediaQuery.of(context).size.width * 1.7,
              left: 100,
              bottom: 100,
              child: Image.asset("assets/backgrounds/Spline.png")),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 10),
              child: const SizedBox(),
            ),
          ),
          const rive.RiveAnimation.asset('assets/riveassets/shapes.riv'),
          Positioned.fill(
              child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 30,
              sigmaY: 30,
            ),
            child: const SizedBox(),
          )),
          AnimatedPositioned(
            top: isSignInDialogshow ? -50 : 0,
            duration: const Duration(milliseconds: 240),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SafeArea(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  const SizedBox(
                    width: 260,
                    child: Column(
                      children: [
                        Text(
                          'Learn design & code',
                          style: TextStyle(
                              fontSize: 60, fontFamily: 'Poppins', height: 1.2),
                        ),
                        SizedBox(height: 16),
                        Text(
                          "Don’t skip design. Learn design and code, by building real apps with Flutter and Swift. Complete courses about the best tools.",
                        ),
                      ],
                    ),
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  AnimationBtn(
                      btnAnimationController: _btnAnimationController,
                      press: () {
                        _btnAnimationController.isActive = true;
                        Future.delayed(const Duration(milliseconds: 800), () {
                          setState(() {
                            isSignInDialogshow = true;
                          });
                          customSignInDialog(context, onClose: (_) {
                            setState(() {
                              isSignInDialogshow = false;
                            });
                          });
                        });
                      }),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Text(
                        'Purchase includes access to 30+ courses, 240+ premium tutorials, 120+ hours of videos, source files and certificates.'),
                  )
                ],
              ),
            )),
          )
        
        ],
      ),
    );
  }
}
