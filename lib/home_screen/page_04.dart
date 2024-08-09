import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    ['Smart Light', 'assets/icon/light-bulb.png', false],
    ['Smart AC', 'assets/icon/air-conditioner.png', false],
    ['Smart TV', 'assets/icon/smart-tv.png', false],
    ['Smart Fan', 'assets/icon/fan.png', false]
  ];

  @override
  void initState() {
    super.initState();
    _loadDeviceStates();
  }

  void _loadDeviceStates() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      for (int i = 0; i < mySmartDevices.length; i++) {
        mySmartDevices[i][2] = prefs.getBool('device_$i') ?? false;
      }
    });
  }

  void _saveDeviceState(int index, bool value) async {//to save data
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('device_$index', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: const Column(
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
              child: const Text('Smart Devices'),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: mySmartDevices.length,
                padding: const EdgeInsets.all(25),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.3,
                ),
                itemBuilder: (context, index) {
                  return SmartDeviceBox(
                    smartDeviceName: mySmartDevices[index][0],
                    iconPath: mySmartDevices[index][1],
                    powerOn: mySmartDevices[index][2],
                    onChanged: (value) => powerSwitchChange(value, index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void powerSwitchChange(bool value, int index) {
    setState(() {
      // Update the state of the specific device
      mySmartDevices[index][2] = value;
      _saveDeviceState(index, value);
    });
  }

}
