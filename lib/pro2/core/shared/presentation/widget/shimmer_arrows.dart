import 'package:flutter/material.dart';

import '../../../theme/sh_icons.dart';

class ShimmerArrows extends StatefulWidget {
  const ShimmerArrows({super.key});

  @override
  State<ShimmerArrows> createState() => _ShimmerArrowsState();
}

class _ShimmerArrowsState extends State<ShimmerArrows>
    with SingleTickerProviderStateMixin {
      late final AnimationController _controller;

      @override
  void initState() {
   _controller=AnimationController.unbounded(vsync: this)
   ..repeat(
    min: -0.5,
    max: 1.5,
    period: const Duration(seconds: 1)
   );
    super.initState();
  }
  @override
  void dispose() {
   _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_,child) {
        return ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: const [Colors.white10, Colors.white, Colors.white10],
            stops: const [0.0, 0.3, 1],
            transform: _SlideGradientTransform(percent: _controller.value)
          ).createShader(bounds),
          child: child,
        );
      },
      child: const Column(
            children: [
              Align(heightFactor: .4, child: Icon(SHIcons.arrowUp)),
              Align(heightFactor: .4, child: Icon(SHIcons.arrowUp)),
              Align(heightFactor: .4, child: Icon(SHIcons.arrowUp)),
            ],
          ),
    );
  }
}
class _SlideGradientTransform extends GradientTransform {
  final double percent;

  const _SlideGradientTransform({required this.percent});
  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
   return Matrix4.translationValues(0, -(bounds.height*percent), 0);
  }
}