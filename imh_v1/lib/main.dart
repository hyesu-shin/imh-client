import 'package:flutter/material.dart';
import 'responsive_home_screen.dart';
// import 'screens/add_event_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'InMyHands',
      theme: ThemeData(
        primarySwatch: Colors.blue, 
      ),
      // home: ResponsiveHomeScreen(),
      initialRoute: '/',
      routes: {
        '/': (context) => ResponsiveHomeScreen(),
      },
    );
  }
}