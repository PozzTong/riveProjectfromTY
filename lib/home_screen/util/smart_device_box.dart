import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SmartDeviceBox extends StatelessWidget {
  final String smartDeviceName;
  final String iconPath;
  final bool powerOn;
  void Function(bool)? onChanged;
  SmartDeviceBox(
      {super.key,
      required this.smartDeviceName,
      required this.iconPath,
      required this.powerOn,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color:powerOn ? Colors.grey[600]:Colors.grey[200], 
              borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: Column(
            children: [
              Image.asset(
                iconPath,
                color: powerOn ? Colors.white:Colors.black,
                height: 65,
              ),
              Row(
                children: [
                  Expanded(
                      child: Text(
                    smartDeviceName,
                    style: TextStyle(color: powerOn ? Colors.white:Colors.black,
                        fontSize: 13, fontWeight: FontWeight.bold),
                  )),
                  Transform.rotate(
                    angle: pi / 2,
                    child: CupertinoSwitch(value: powerOn, onChanged: onChanged),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
