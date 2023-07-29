import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';


class AppProvider extends InheritedWidget {
  AppProvider({Key? key, required Widget child})
      : super(key: key, child: child);

  final childBeamerKey = GlobalKey<BeamerState>();

  static AppProvider of(BuildContext context) {
    return context
        .getElementForInheritedWidgetOfExactType<AppProvider>()!
        .widget as AppProvider;
  }

  @override
  bool updateShouldNotify(AppProvider oldWidget) {
    return false;
  }
}
