import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_app6/screens/auth_screen.dart';
import 'package:flutter_app6/screens/splash_screen.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import './screens/chat_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      title: 'BBC Chat',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: NeumorphicThemeData(
        baseColor: Color(0xFFFFFFFF),
        lightSource: LightSource.topLeft,
        depth: 10,
      ),
      darkTheme: NeumorphicThemeData(
        baseColor: Color(0xFF3E3E3E),
        lightSource: LightSource.topLeft,
        depth: 6,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (ctx, userSanpshot) {
          if (userSanpshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          }
          if (userSanpshot.hasData) {
            return ChatScreen();
          }
          return AuthScreen();
        },
      ),
    );
    // MaterialApp(
    //   title: 'Flutter Chat',
    //   theme: ThemeData(
    //     primarySwatch: Colors.pink,
    //     backgroundColor: Colors.pink,
    //     accentColor: Colors.deepPurple,
    //     accentColorBrightness: Brightness.dark,
    //     visualDensity: VisualDensity.adaptivePlatformDensity,
    //     buttonTheme: ButtonTheme.of(context).copyWith(
    //       buttonColor: Colors.pink,
    //       textTheme: ButtonTextTheme.primary,
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(20),
    //       ),
    //     ),
    //   ),
    //   home: StreamBuilder(
    //     stream: FirebaseAuth.instance.onAuthStateChanged,
    //     builder: (ctx, userSanpshot) {
    //       if (userSanpshot.connectionState == ConnectionState.waiting) {
    //         return SplashScreen();
    //       }
    //       if (userSanpshot.hasData) {
    //         return ChatScreen();
    //       }
    //       return AuthScreen();
    //     },
    //   ),
    // );
  }
}
