import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'responsive_home_screen.dart';
import 'models/object_model.dart';

import 'blocs/index.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize Hive and open boxes properly
    await Hive.initFlutter();

    // Register the adapters for each model
    Hive.registerAdapter(ObjectModelAdapter());  // Register ObjectModel adapter

    await Hive.openBox<ObjectModel>('objects_box');  // Or any other boxes
  } catch (e) {
    print('Error initializing Hive: $e');
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProviders.getProviders(
      child: MaterialApp(
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
      ),
    );
  }
}