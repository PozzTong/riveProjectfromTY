
import 'package:flutter/material.dart';

import '../../../core/shared/domain/entities/smart_room.dart';
import '../../../core/shared/presentation/widget/blue_dot_light.dart';
import '../../../core/shared/presentation/widget/sh_card.dart';
import '../../../core/shared/presentation/widget/sh_switcher.dart';
import '../../../core/theme/sh_icons.dart';

class LightsAndTimerSwitchers extends StatefulWidget {
  const LightsAndTimerSwitchers({
    required this.room,
    super.key,
  });

  final SmartRoom room;

  @override
  State<LightsAndTimerSwitchers> createState() =>
      _LightsAndTimerSwitchersState();
}

class _LightsAndTimerSwitchersState extends State<LightsAndTimerSwitchers> {
  late bool isLightOn;
  late bool isTimerOn;

  @override
  void initState() {
    super.initState();
    isLightOn = widget.room.lights.isOn;
    isTimerOn = widget.room.timer.isOn;
  }

  void _toggleLight(bool value) {
    setState(() {
      isLightOn = value;
      widget.room.lights.isOn == value;
    });
  }

  void _toggleTimer(bool value) {
    setState(() {
      isTimerOn = value;
      widget.room.timer.isOn == value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SHCard(
      childrenPadding: const EdgeInsets.all(12),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Lights'),
            const SizedBox(height: 8),
            SHSwitcher(
              value: isLightOn,
              onChanged: _toggleLight,
              icon: const Icon(SHIcons.lightBulbOutline),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('Timer'),
                const Spacer(),
                isTimerOn ? const BlueLightDot() : const BlackLightDot()
              ],
            ),
            const SizedBox(height: 8),
            SHSwitcher(
              value: isTimerOn,
              icon: isTimerOn
                  ? const Icon(SHIcons.timer)
                  : const Icon(SHIcons.timerOff),
              onChanged: _toggleTimer,
            ),
          ],
        ),
      ],
    );
  }
}
