import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rive/rive.dart';

import '../../entry_point.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    super.key,
  });

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool isShowLoading = false;
  bool isShowConfetti = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late SMITrigger check;
  late SMITrigger error;
  late SMITrigger reset;

  late SMITrigger confetti;

  StateMachineController getRiveController(Artboard artboard) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, 'State Machine 1');
    artboard.addController(controller!);
    return controller;
  }

  void signIn(BuildContext context) {
    setState(() {
      isShowLoading = true;
      isShowConfetti = true;
    });
    Future.delayed(const Duration(seconds: 1), () {
      if (_formKey.currentState!.validate()) {
        check.fire();
        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            isShowLoading = false;
          });

          confetti.fire();
          Future.delayed(const Duration(seconds: 1), () {
            // Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const EntryPoint(),
              ),
            );
          });
        });
      } else {
        error.fire();
        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            isShowLoading = false;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Email',
                  style: TextStyle(color: Colors.black54),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 16),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "";
                      }
                      return null;
                    },
                    onSaved: (email) {},
                    decoration: InputDecoration(
                        prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: SvgPicture.asset('assets/icons/email.svg'),
                    )),
                  ),
                ),
                const Text(
                  'PassWord',
                  style: TextStyle(color: Colors.black54),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 16),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "";
                      }
                      return null;
                    },
                    onSaved: (password) {},
                    obscureText: true, //hide password
                    obscuringCharacter: '\$', // show on hide
                    decoration: InputDecoration(
                        prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: SvgPicture.asset('assets/icons/password.svg'),
                    )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 24),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      signIn(context);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF77DBE),
                        minimumSize: const Size(double.infinity, 56),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(25),
                                bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25)))),
                    icon: const Icon(
                      CupertinoIcons.arrow_right,
                      color: Color(0xFFFE0037),
                    ),
                    label: const Text('Sign In'),
                  ),
                )
              ],
            )),
        isShowLoading
            ? CustomPosition(
                child: RiveAnimation.asset(
                  "assets/riveassets/check.riv",
                  onInit: (artboard) {
                    StateMachineController controller =
                        getRiveController(artboard);
                    check = controller.findSMI('Check') as SMITrigger;
                    error = controller.findSMI('Error') as SMITrigger;
                    reset = controller.findSMI('Reset') as SMITrigger;
                  },
                ),
              )
            : const SizedBox(),
        isShowConfetti
            ? CustomPosition(
                child: Transform.scale(
                scale: 6,
                child: RiveAnimation.asset(
                  'assets/riveassets/confetti.riv',
                  onInit: (artboard) {
                    StateMachineController controller =
                        getRiveController(artboard);

                    confetti =
                        controller.findSMI('Trigger explosion') as SMITrigger;
                  },
                ),
              ))
            : const SizedBox()
      ],
    );
  }
}

class CustomPosition extends StatelessWidget {
  const CustomPosition({super.key, required this.child, this.size = 100});

  final Widget child;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
        child: Column(
      children: [
        const Spacer(),
        SizedBox(
          height: size,
          width: size,
          child: child,
        ),
        const Spacer(
          flex: 2,
        ),
      ],
    ));
  }
}
