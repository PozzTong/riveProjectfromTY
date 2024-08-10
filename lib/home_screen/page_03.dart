import 'package:flutter/material.dart';

import '../pro2/core/app/app.dart';
import '../pro2/core/theme/sh_color.dart';

class PageThree extends StatefulWidget {
  const PageThree({super.key});

  @override
  State<PageThree> createState() => _PageThreeState();
}

class _PageThreeState extends State<PageThree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: SafeArea(
        child: Center(
          child: GestureDetector(
            child: Container(
              height: 50,
              width: 70,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color:SHColors.cardColor ),
              child: const Center(child: Text('Home',style: TextStyle(color: Colors.white),))),
            onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const SmartHomeApp()));
          },),
        ),
      )
    );
  }
}
