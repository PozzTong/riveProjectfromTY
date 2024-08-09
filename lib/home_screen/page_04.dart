import 'package:flutter/material.dart';
import 'util/smart_device_box.dart';
class PageFour extends StatefulWidget {
  const PageFour({super.key});

  @override
  State<PageFour> createState() => _PageFourState();
}

class _PageFourState extends State<PageFour> {
  final double horizontalPadding = 40;
  final double verticalPadding = 25;
  List mySmartDevices = [
    ['Smart Light', 'assets/icon/light-bulb.png', true],
    ['Smart AC', 'assets/icon/air-conditioner.png', false],
    ['Smart TV', 'assets/icon/smart-tv.png', false],
    ['Smart Fan', 'assets/icon/fan.png', false]
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      // appBar: AppBar(title: const Text('Page Four')),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding, vertical: verticalPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/icon/menu.png',
                      height: 45, color: Colors.grey[800]),
                  Icon(
                    Icons.person,
                    size: 45,
                    color: Colors.grey[800],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome Home'),
                  Text(
                    'Tong',
                    style: TextStyle(fontSize: 40),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: const Text('Start Devices'),
            ),
            Expanded(
                child: GridView.builder(
                    itemCount: mySmartDevices.length,
                    padding: const EdgeInsets.all(25),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1/1.3
                        ),
                    itemBuilder: (context, index) {
                      return SmartDeviceBox(
                        smartDeviceName: mySmartDevices[index][0],
                        iconPath: mySmartDevices[index][1],
                        powerOn: mySmartDevices[index][2],
                        onChanged: (value) => powerSwitchChange(value,index),
                      );
                    }))
          ],
        ),
      ),
    );
  }
  
  powerSwitchChange(bool value,int index) {
   setState(() {
     mySmartDevices[index][2]=value;
   });
  }
}
