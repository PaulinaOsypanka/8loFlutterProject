import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lo_news/job_model.dart';

import 'colors.dart';

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
