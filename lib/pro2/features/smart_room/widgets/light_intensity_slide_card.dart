// import 'package:flutter/material.dart';

// import '../../../core/shared/domain/entities/smart_room.dart';
// import '../../../core/shared/presentation/widget/sh_card.dart';
// import '../../../core/shared/presentation/widget/sh_switcher.dart';
// import '../../../core/theme/sh_icons.dart';

// class LightIntensitySliderCard extends StatelessWidget {
//   const LightIntensitySliderCard({
//     required this.room,
//     super.key,
//   });

//   final SmartRoom room;

//   @override
//   Widget build(BuildContext context) {
//     return SHCard(
//       childrenPadding: const EdgeInsets.all(12),
//       children: [
//         _LightSwitcher(room: room),
//         Row(
//           children: [
//             const Icon(SHIcons.lightMin),
//             Expanded(
//               child: Slider(
//                 value: .4,
//                 onChanged: (value) {},
//               ),
//             ),
//             const Icon(SHIcons.lightMax),
//           ],
//         )
//       ],
//     );
//   }
// }

// class _LightSwitcher extends StatelessWidget {
//   const _LightSwitcher({
//     required this.room,
//   });

//   final SmartRoom room;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         const Flexible(
//           child: FittedBox(
//             fit: BoxFit.scaleDown,
//             child: Text('Light intensity'),
//           ),
//         ),
//         Flexible(
//           child: FittedBox(
//             fit: BoxFit.scaleDown,
//             child: Text(
//               '${room.lights.value}%',
//               style: const TextStyle(fontSize: 20),
//             ),
//           ),
//         ),
//         SHSwitcher(
//           value: room.lights.isOn,
//           onChanged: (value) {},
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:onyoutube/pro2/core/core.dart';

import '../../../core/shared/domain/entities/smart_room.dart';
import '../../../core/shared/presentation/widget/sh_card.dart';
import '../../../core/shared/presentation/widget/sh_switcher.dart';
import '../../../core/theme/sh_icons.dart';

class LightIntensitySliderCard extends StatefulWidget {
  const LightIntensitySliderCard({
    required this.room,
    super.key,
  });

  final SmartRoom room;

  @override
  State<LightIntensitySliderCard> createState() =>
      _LightIntensitySliderCardState();
}

class _LightIntensitySliderCardState extends State<LightIntensitySliderCard> {
  late double lightIntensity;
  late bool isLightOn;

  @override
  void initState() {
    super.initState();
    lightIntensity = widget.room.lights.value / 100.0;
    isLightOn = widget.room.lights.isOn;
  }

  void _updateLightIntensity(double value) {
    setState(() {
      lightIntensity = value;
      widget.room.lights.value == (value * 100).round();
    });
  }

  void _toggleLight(bool value) {
    setState(() {
      isLightOn = value;
      widget.room.lights.isOn == value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SHCard(
      childrenPadding: const EdgeInsets.all(12),
      children: [
        _LightSwitcher(
          room: widget.room,
          onToggle: _toggleLight,
          lightIntensity: (lightIntensity * 100).round(),
          isLightOn: isLightOn,
        ),
        Row(
          children: [
            const Icon(SHIcons.lightMin),
            Expanded(
              child: Slider(
                value: lightIntensity,
                onChanged: isLightOn ? _updateLightIntensity : null,
                min: 0,
                max: 1,
              ),
            ),
            const Icon(SHIcons.lightMax),
          ],
        ),
      ],
    );
  }
}

class _LightSwitcher extends StatelessWidget {
  const _LightSwitcher({
    required this.room,
    required this.onToggle,
    required this.lightIntensity,
    required this.isLightOn,
  });

  final SmartRoom room;
  final ValueChanged<bool> onToggle;
  final int lightIntensity;
  final bool isLightOn;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text('Light intensity'),
          ),
        ),
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child:isLightOn ? Text(
               '$lightIntensity%',
              style: const TextStyle(fontSize: 20),
            ):Text('$lightIntensity%',style: const TextStyle(color: Colors.white38),)
          ),
        ),
        SHSwitcher(
          value: isLightOn,
          onChanged: onToggle,
        ),
      ],
    );
  }
}
