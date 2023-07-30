import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:lo_news/extensions.dart';
import 'package:lo_news/widgets/job_list.dart';
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
              scaffoldBackgroundColor: const Color.fromARGB(255, 18, 18, 18),
              primarySwatch: MaterialColorGenerator.from(
                  const Color.fromARGB(255, 15, 15, 15)),
              chipTheme: const ChipThemeData(
                  labelStyle: TextStyle(
                      fontSize: 11, color: Color.fromARGB(255, 255, 255, 255))),
              appBarTheme: const AppBarTheme(
                backgroundColor: Color.fromARGB(255, 15, 15, 15),
                elevation: 1.0,
                iconTheme: IconThemeData(color: Colors.black),
                titleTextStyle: TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontWeight: FontWeight.bold,
                ),
              ),
              textTheme: const TextTheme(
                titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color.fromARGB(192, 255, 255, 255),
                ),
                bodyLarge: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Color.fromARGB(213, 255, 255, 255),
                ),
                bodyMedium: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(213, 255, 255, 255),
                  fontSize: 18,
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

class MaterialColorGenerator {
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
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          title: const Text(
            "Aktualności 8lo",
            style: TextStyle(
                color: lightYellow,
                fontSize: 24,
                letterSpacing: 5,
                fontWeight: FontWeight.bold),
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: CircleAvatar(
                  radius: 22,
                  backgroundColor: const Color(0x00000000),
                  foregroundImage: const NetworkImage(
                      'https://ugc.production.linktr.ee/7Qv9UNw5TGaKySDCRjrr_KlLss0HzhZRMAZSZ',
                      scale: 0.7),
                  child: GestureDetector(
                    onTap: () {
                      html.window
                          .open('https://linktr.ee/su8lokrakow', 'linktree');
                    },
                  ),
                )),
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
              color: const Color.fromARGB(255, 18, 18, 18),
              margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: listviewMaxWidth, child: const JobList()),
                  Container(
                    color: const Color.fromARGB(255, 24, 24, 24),
                    child: SizedBox(
                      width: detailMaxWidth,
                      child: Beamer(
                        key: context.provider.childBeamerKey,
                        routerDelegate: innerRouterDelegate,
                      ),
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
