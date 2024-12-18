import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/add_event_screen.dart';

Map<String, WidgetBuilder> getAppRoutes() {
  return {
    '/': (context) => HomeScreen(),
    '/add-event': (context) => AddEventScreen(),
  };
}
