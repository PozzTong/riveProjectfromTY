import 'package:flutter/material.dart';
import '../../../../core/shared/domain/entities/smart_room.dart';
import '../../../../core/shared/presentation/widget/room_card.dart';
import '../../../smart_room/screen/room_detail_screen.dart';

class SmartRoomsPageView extends StatelessWidget {
  const SmartRoomsPageView({
    super.key,
    required this.controller,
    required this.pageListener,
    required this.roomSelectNotifier,
  });

  final PageController controller;
  final ValueNotifier pageListener;
  final ValueNotifier roomSelectNotifier;

  double _getOffsetX(double percent) => percent.isNegative ? 30 : -30;
  Matrix4 _getOutTranslate(
      {required double percent,
      required int selectedRoom,
      required int index}) {
    final double x =
        selectedRoom != index && selectedRoom != -1 ? _getOffsetX(percent) : 0;
    return Matrix4.translationValues(x, 0, 0);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: pageListener,
        builder: (_, page, __) {
          return ValueListenableBuilder(
              valueListenable: roomSelectNotifier,
              builder: (_, selected, __) {
                return PageView.builder(
                  controller: controller,
                  clipBehavior: Clip.none,
                  itemCount: SmartRoom.fakeValues.length,
                  itemBuilder: (_, index) {
                    final room = SmartRoom.fakeValues[index];
                    double percent = page - index;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      transform: _getOutTranslate(
                          percent: percent,
                          selectedRoom: selected,
                          index: index),
                      curve: Curves.fastOutSlowIn,
                      child: RoomCard(
                        percent: percent,
                        expand: selected == index,
                        room: room,
                        onSwipeUp: () => roomSelectNotifier.value = index,
                        onSwipeDown: () => roomSelectNotifier.value = -1,
                        onTap: () {
                          if (selected == index) {
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration: const Duration(milliseconds: 800),
                                  reverseTransitionDuration: const Duration(milliseconds: 800),
                                    pageBuilder: (_, animated, __) =>
                                        FadeTransition(
                                          opacity: animated,
                                          child: RoomDetailScreen(room: room)))
                                // MaterialPageRoute(
                                //   builder: (context) =>
                                //       RoomDetailScreen(room: room),
                                // ),
                                );
                            roomSelectNotifier.value = -1;
                          }
                        },
                      ),
                    );
                  },
                );
              });
        });
  }
}
