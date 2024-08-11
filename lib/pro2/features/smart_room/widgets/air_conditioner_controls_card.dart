import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/shared/domain/entities/smart_room.dart';
import '../../../core/shared/presentation/widget/sh_card.dart';
import '../../../core/shared/presentation/widget/sh_switcher.dart';
import '../../../core/theme/sh_color.dart';
import '../../../core/theme/sh_icons.dart';

class AirConditionerControlsCard extends StatelessWidget {
  const AirConditionerControlsCard({
    required this.room,
    super.key,
  });

  final SmartRoom room;

  @override
  Widget build(BuildContext context) {
    return SHCard(
      childrenPadding: const EdgeInsets.all(12),
      children: [
        _AirSwitcher(room: room),
        const _AirIcons(),
        Column(
          children: [
            Row(
              children: [
                Container(
                  width: 120,
                  height: 50,
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    border: Border.all(
                      width: 10,
                      color: Colors.white38,
                    ),
                  ),
                ),
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(
                          SHIcons.waterDrop,
                          color: Colors.white38,
                          size: 20,
                        ),
                        Text(
                          'Air humidity',
                          style: GoogleFonts.montserrat(
                            fontSize: 10,
                            color: Colors.white60,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text('${room.airHumidity.toInt()}%'),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        )
      ],
    );
  }
}

class _AirIcons extends StatelessWidget {
  const _AirIcons();

  @override
  Widget build(BuildContext context) {
    return const IconTheme(
      data: IconThemeData(size: 30, color: Colors.white38),
      child: Row(
        children: [
          Icon(SHIcons.snowFlake),
          SizedBox(
            width: 8,
          ),
          Icon(SHIcons.wind),
          SizedBox(
            width: 8,
          ),
          Icon(SHIcons.waterDrop),
          SizedBox(
            width: 8,
          ),
          Icon(SHIcons.timer, color: SHColors.selectedColor),
        ],
      ),
    );
  }
}

class _AirSwitcher extends StatefulWidget {
  const _AirSwitcher({
    required this.room,
  });

  final SmartRoom room;

  @override
  State<_AirSwitcher> createState() => _AirSwitcherState();
}

class _AirSwitcherState extends State<_AirSwitcher> {
  late bool airOn;
  late double temperature;

  @override
  void initState() {
    super.initState();
    airOn = widget.room.airCondition.isOn;
    temperature = widget.room.airCondition.value.toDouble();

    // Ensure the temperature is within the slider's range
    if (temperature < 16.0) {
      temperature = 16.0;
    } else if (temperature > 30.0) {
      temperature = 30.0;
    }
  }

  void _toggleAir(bool value) {
    setState(() {
      airOn = value;
      widget.room.airCondition.isOn == value;
    });
  }

  void _updateTemperature(double value) {
    setState(() {
      temperature = value;
      widget.room.airCondition.value == value.toInt();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Air conditioning'),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: SHSwitcher(
                icon: const Icon(SHIcons.fan),
                value: airOn,
                onChanged: _toggleAir,
              ),
            ),
            const Spacer(),
            Text(
              '${temperature.toInt()}˚',
              style: const TextStyle(fontSize: 28),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Slider(
          value: temperature,
          min: 16.0,
          max: 30.0,
          divisions: 14,
          onChanged: airOn ? _updateTemperature : null,
          activeColor: SHColors.selectedColor,
          inactiveColor: Colors.grey,
        ),
      ],
    );
  }
}
