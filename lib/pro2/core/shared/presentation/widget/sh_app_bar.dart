import 'package:flutter/material.dart';
import 'package:onyoutube/home_screen/page_04.dart';

import '../../../../../home_screen/page_03.dart';
import '../../../../../pro1/entry_point.dart';
import '../../../theme/sh_icons.dart';

class ShAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ShAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Hero(
        tag: "app-bar-icon-1",
        child: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const EntryPoint()));
          },
          icon: const Icon(SHIcons.menu),
        ),
      ),
      actions: [
        Hero(
          tag: "app-bar-icon-2",
          child: Material(
            type: MaterialType.transparency,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(SHIcons.search),
            ),
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}
