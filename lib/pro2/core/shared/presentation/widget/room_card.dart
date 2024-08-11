import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:onyoutube/pro2/features/smart_room/screen/room_detail_screen.dart';
import 'package:ui_common/ui_common.dart';
import '../../../../features/home/presentation/widgets/background_room_lights.dart';
import '../../../theme/sh_color.dart';
import '../../../theme/sh_icons.dart';
import '../../domain/entities/smart_room.dart';
import 'animated_upward_arrows.dart';
import 'parallax_image_card.dart';

class RoomCard extends StatelessWidget {
  const RoomCard({
    required this.percent,
    required this.room,
    required this.expand,
    required this.onSwipeUp,
    required this.onSwipeDown,
    required this.onTap,
    super.key,
  });

  final double percent;
  final SmartRoom room;
  final VoidCallback onSwipeUp;
  final VoidCallback onSwipeDown;
  final VoidCallback onTap;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 200),
      curve: Curves.fastOutSlowIn,
      tween: Tween(begin: 0, end: expand ? 1 : 0),
      builder: (_, value, __) => Stack(
        fit: StackFit.expand,
        children: [
          // -----------------------------------------------
          // Background information card
          // -----------------------------------------------
          Transform.scale(
            scale: lerpDouble(0.8, 1.2, value),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 180),
              child: BackgroundRoomCard(room: room, translation: value),
            ),
          ),
          // -----------------------------------------------
          // Room image card with parallax effect
          // -----------------------------------------------
          Padding(
            padding: const EdgeInsets.only(bottom: 200),
            child: Transform(
              transform: Matrix4.translationValues(0, -90 * value, 0),
              child: GestureDetector(
                onTap: onTap,
                onVerticalDragUpdate: (details) {
                  if (details.primaryDelta! < -10) onSwipeUp();
                  if (details.primaryDelta! > 10) onSwipeDown();
                },
                child: Hero(
                  tag: room.id,
                  flightShuttleBuilder: (_, animation, __, ___, ____) {
                    return AnimatedBuilder(
                      animation: animation,
                      builder: (_,child) {
                        return RoomDetailItems(
                            room: room, 
                            topPadding: context.mediaQuery.padding.top,
                            animation: animation,
                            );
                      }
                    );
                  },
                  child: Stack(
                    fit: StackFit.expand,
                    clipBehavior: Clip.none,
                    children: [
                      ParallaxImageCard(
                        imageUrl: room.imageUrl,
                        parallaxValue: percent,
                      ),
                      VerticalRoomTitle(room: room),
                      const CameraIconButton(),
                      const AnimatedUpwardArrows()
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CameraIconButton extends StatelessWidget {
  const CameraIconButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Align(
        alignment: Alignment.topRight,
        child: IconButton(
          onPressed: () {},
          icon: const Icon(
            SHIcons.camera,
            color: SHColors.textColor,
          ),
        ),
      ),
    );
  }
}

class VerticalRoomTitle extends StatelessWidget {
  const VerticalRoomTitle({
    required this.room,
    super.key,
  });

  final SmartRoom room;

  @override
  Widget build(BuildContext context) {
    // final dx = 50 * animationValue;
    // final opacity = 1 - animationValue;
    return Align(
      alignment: Alignment.centerLeft,
      child: RotatedBox(
        quarterTurns: -1,
        child: FittedBox(
          child: Padding(
            padding: EdgeInsets.only(left: 40.h, right: 20.h, top: 12.w),
            child: Text(
              room.name.replaceAll(' ', ''),
              maxLines: 1,
              style: context.displayLarge.copyWith(color: SHColors.textColor),
            ),
          ),
        ),
      ),
    );
  }
}
