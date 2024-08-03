import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'sign_in_form.dart';

Future<Object?> customSignInDialog(BuildContext context,
    {required ValueChanged onClose}) {
  return showGeneralDialog(
    barrierDismissible: true,
    barrierLabel: 'Sign In',
    context: context,
    transitionDuration: const Duration(milliseconds: 600),
    transitionBuilder: (_, animation, __, child) {
      Tween<Offset> tween;
      tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
      return SlideTransition(
        position: tween.animate(
          CurvedAnimation(parent: animation, curve: Curves.easeInOut),
        ),
        child: child,
      );
    },
    pageBuilder: (context, _, __) => Center(
      child: Container(
        height: 620,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.94),
          borderRadius: const BorderRadius.all(Radius.circular(40)),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            clipBehavior: Clip.none,
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Sign In',
                      style: TextStyle(fontSize: 34, fontFamily: 'Poppins'),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      child: Text(
                        "Don’t skip design. Learn design and code, by building real apps with Flutter and Swift.",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SignInForm(),
                    const Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Or',
                            style: TextStyle(color: Colors.black26),
                          ),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        'Sign up with Email, Apple or Google',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            'assets/icons/email_box.svg',
                            height: 40,
                            width: 40,
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            'assets/icons/apple_box.svg',
                            height: 40,
                            width: 40,
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            'assets/icons/google_box.svg',
                            height: 40,
                            width: 40,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: -70,
                left: 0,
                right: 0,
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.white,
                  child: Center(
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  ).then(onClose);
}
