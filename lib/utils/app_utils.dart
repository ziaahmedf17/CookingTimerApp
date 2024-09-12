import 'package:flutter/material.dart';

class AppUtils {
  AppUtils._();

  static width(context) => MediaQuery.sizeOf(context).width;

  static height(context) => MediaQuery.sizeOf(context).height;

  static Future<TimeOfDay?> timePicker(BuildContext context) {
    return showTimePicker(
      initialTime: const TimeOfDay(hour: 3, minute: 45),
      context: context,
    );
  }

}

class Nav {
  Nav._();

  static final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  static to(Widget screen) {
    Navigator.push(navKey.currentState!.context,
        MaterialPageRoute(builder: (_) => screen));
  }
}