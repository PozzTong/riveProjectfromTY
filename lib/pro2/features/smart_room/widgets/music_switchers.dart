import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/shared/domain/entities/smart_room.dart';
import '../../../core/shared/presentation/widget/sh_card.dart';
import '../../../core/shared/presentation/widget/sh_switcher.dart';
import '../../../core/theme/sh_color.dart';
import '../../../core/theme/sh_icons.dart';

class MusicSwitchers extends StatefulWidget {
  const MusicSwitchers({
    required this.room,
    super.key,
  });

  final SmartRoom room;

  @override
  State<MusicSwitchers> createState() => _MusicSwitchersState();
}

class _MusicSwitchersState extends State<MusicSwitchers> {
  late bool isMusicOn;

  @override
  void initState() {
    super.initState();
    isMusicOn = widget.room.musicInfo.isOn;
  }

  void _toggleMusic(bool value) {
    setState(() {
      isMusicOn = value;
      widget.room.musicInfo.isOn == value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SHCard(
      childrenPadding: const EdgeInsets.all(12),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Row(
              children: [
                Text('Music'),
                Spacer(),
                Icon(Icons.open_in_new_rounded),
              ],
            ),
            const SizedBox(height: 8),
            SHSwitcher(
              value: isMusicOn,
              icon: const Icon(SHIcons.music),
              onChanged: _toggleMusic,
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.room.musicInfo.currentSong.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              widget.room.musicInfo.currentSong.artist,
              style: GoogleFonts.montserrat(
                color: SHColors.selectedColor,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
            IconTheme(
              data: const IconThemeData(size: 20, color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Flexible(child: Icon(Icons.fast_rewind)),
                  const SizedBox(width: 8),
                  Flexible(
                    child: isMusicOn
                        ? const Icon(Icons.pause)
                        : const Icon(Icons.play_arrow),
                  ),
                  const SizedBox(width: 8),
                  const Flexible(child: Icon(Icons.fast_forward)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
