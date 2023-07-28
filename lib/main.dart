import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:pwa_demo/extensions.dart';
import 'package:pwa_demo/widgets/job_list.dart';
import 'dart:html' as html;

import '/app_provider.dart';
import '/beamer_locations.dart';
import '/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final routerDelegate = BeamerDelegate(
    locationBuilder: (routeInformation, _) {
      return HomeLocation();
    },
  );

  @override
  Widget build(BuildContext context) {
    return AppProvider(
      child: LayoutBuilder(builder: (context, constraint) {
        return MaterialApp.router(
          title: 'Aktualności 8lo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: MaterialColorGenerator.from( const Color.fromARGB(255, 15, 15, 15)),
              chipTheme: const ChipThemeData(
                  labelStyle: TextStyle(
                fontSize: 11,
              )),
              appBarTheme: const AppBarTheme(
                backgroundColor:  Color.fromARGB(255, 15, 15, 15),
                elevation: 1.0,
                iconTheme: IconThemeData(color: Colors.black),
                titleTextStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              textTheme: const TextTheme(
                headline6: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                bodyText1: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                bodyText2: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Color(0xff5656565),
                  fontSize: 12,
                ),
              )),
          routeInformationParser: BeamerParser(),
          routerDelegate: routerDelegate,
          backButtonDispatcher:
              BeamerBackButtonDispatcher(delegate: routerDelegate),
        );
      }),
    );
  }
}
class MaterialColorGenerator{
  static MaterialColor from(Color color) {
    return MaterialColor(color.value, <int, Color>{
      50: color.withOpacity(0.1),
      100: color.withOpacity(0.2),
      200: color.withOpacity(0.3),
      300: color.withOpacity(0.4),
      400: color.withOpacity(0.5),
      500: color.withOpacity(0.6),
      600: color.withOpacity(0.7),
      700: color.withOpacity(0.8),
      800: color.withOpacity(0.9),
      900: color.withOpacity(1.0),
    });
  }
}
/// Design inspired by this deisgn https://dribbble.com/shots/17092342-Job-Finder-App
class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  final int currentIndex;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final innerRouterDelegate = BeamerDelegate(
    transitionDelegate: const NoAnimationTransitionDelegate(),
    locationBuilder: (routeInformation, _) {
      return InnerJobLocation();
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          title: const Text(
            "Aktualności 8lo",
            style: TextStyle(
                color: lightGreen,
                fontSize: 24,
                letterSpacing: 5,
                fontWeight: FontWeight.bold),
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: GestureDetector(
                  onTap: () {
                    html.window
                        .open('https://linktr.ee/su8lokrakow', 'linktree');
                  },
                  child: const CircleAvatar(
                    radius: 29,
                    backgroundColor: const Color(0xFF121212),
                    foregroundImage: AssetImage('img/logo.png'),
                  ),
                ))
          ],
          centerTitle: false,
          backgroundColor: const Color(0xFF121212),
          elevation: 1.0,
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (!context.isLargeScreen) {
            return const JobList();
          } else {
            // for extremely large screens introduce extra margin
            final horizontalMargin =
                context.isExpanded ? constraints.maxWidth * .1 : 0.0;

            final listviewMaxWidth =
                constraints.maxWidth * (context.isExpanded ? 0.3 : 0.4);
            final detailMaxWidth =
                constraints.maxWidth * (context.isExpanded ? 0.5 : 0.6);

            return Container(
              color: Color.fromARGB(255, 24, 24, 24),
              margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: listviewMaxWidth, child: const JobList()),
                  SizedBox(
                    width: detailMaxWidth,
                    child: Beamer(
                      key: context.provider.childBeamerKey,
                      routerDelegate: innerRouterDelegate,
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
