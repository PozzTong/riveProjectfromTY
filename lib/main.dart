import 'package:flutter/material.dart';

import 'screen/onboard_animation.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Flutter Way',
      theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFEEF1F8),
          primarySwatch: Colors.blue,
          fontFamily: 'Intel',
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(foregroundColor: Colors.white)),
          inputDecorationTheme:
               const InputDecorationTheme(
                filled: true, 
                fillColor: Colors.white,
                errorStyle: TextStyle(height: 0),
                border: defaultInputBorder,
                enabledBorder: defaultInputBorder,
                focusedBorder: defaultInputBorder,
                errorBorder: defaultInputBorder
                
                )),
      home: const OnboardAnimation(),
    );
  }
}
const defaultInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(16)),
  borderSide: BorderSide(
    color: Color(0xFFDEE3F2),
    width: 1,
  ),
);

