import 'dart:developer';

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:lo_news/extensions.dart';
import 'package:lo_news/main.dart';

import 'widgets/detail_widgets.dart';
import 'article.dart';

class HomeLocation extends BeamLocation<BeamState> {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    Article? job;

    if (BuildContextExt.jobs != null) {
      try {
        job = BuildContextExt.jobs!.firstWhere(
            (element) => element.link == '${state.uri.path.substring(1)}/');
      } catch (e) {
        log(e.toString());
      }

      return [
        const BeamPage(
          key: ValueKey('home'),
          title: "Home",
          name: '/',
          child: MyHomePage(
            currentIndex: 0,
          ),
        ),
        if (!context.isLargeScreen)
          BeamPage(
            key: ValueKey('job-${job!.link}'),
            title: job.title,
            name: '/:link',
            child: JobDetailWidget(
              model: job,
            ),
          ),
      ];
    } else {
      return [
        const BeamPage(
          key: ValueKey('home'),
          title: "Home",
          name: '/',
          child: MyHomePage(
            currentIndex: 0,
          ),
        )
      ];
    }
  }

  @override
  List<Pattern> get pathPatterns => ['/:link'];
}

class InnerJobLocation extends BeamLocation<BeamState> {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    Article? job;

    if (BuildContextExt.jobs != null) {
      try {
        job = BuildContextExt.jobs!.firstWhere(
            (element) => element.link == '${state.uri.path.substring(1)}/');
      } catch (e) {
        job = BuildContextExt.jobs!.first;
      }

      return [
        if (state.pathParameters.containsKey('link'))
          BeamPage(
            key: ValueKey('job-${job.link}'),
            title: "job.title",
            name: '/:id',
            child: JobDetailWidget(
              model: job,
            ),
          )
        else
          BeamPage(
            key: ValueKey('job-${job.link}'),
            title: job.title,
            name: '/0',
            child: JobDetailWidget(
              model: job,
            ),
          ),
      ];
    } else {
      return [
        const BeamPage(
          key: ValueKey('home'),
          title: "Home",
          name: '/',
          child: MyHomePage(
            currentIndex: 0,
          ),
        )
      ];
    }
  }

  @override
  List<Pattern> get pathPatterns => ['/:id'];
}
