import 'package:flutter/material.dart';

import '../../../../core/theme/sh_icons.dart';

class SmHomeBottomNavigationBar extends StatelessWidget {
  const SmHomeBottomNavigationBar({
    super.key,
    required this.selectedRoomNotifier,
  });
  final ValueNotifier selectedRoomNotifier;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ValueListenableBuilder(
          valueListenable: selectedRoomNotifier,
          builder: (_, selectedRoom, child) {
            return AnimatedOpacity(
              opacity: selectedRoom == -1 ? 1 : 0,
              duration: const Duration(microseconds: 200),
              child: AnimatedContainer(
                duration: const Duration(milliseconds:200),
                transform: Matrix4.translationValues(
                    0, selectedRoom == -1 ? 0 : -30, 0),
                child: BottomNavigationBar(
                  items: const [
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(SHIcons.lock),
                      ),
                      label: 'UNLOCK',
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(SHIcons.home),
                      ),
                      label: 'MAIN',
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(SHIcons.settings),
                      ),
                      label: 'SETTINGS',
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
