import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import '../extensions.dart';
import '../article.dart';
import '../service/api_service.dart';

import '../colors.dart';

class JobList extends StatelessWidget {
  const JobList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Article>?>(
        future: ApiService().getArticles(), // Your API Call here
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              BuildContextExt.jobs = snapshot.data;
              return ListView.builder(
                itemCount: snapshot.data!.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (c, index) => JobCard(
                  model: snapshot.data![index],
                ),
              );
            } else {
              return const Text("Connection error");
            }
          } else if (snapshot.hasError) {
            return const Text('Error');
          } else {
            return const SizedBox(
              width: 20,
              height: 30,
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

class JobCard extends StatelessWidget {
  const JobCard({
    Key? key,
    required this.model,
  }) : super(key: key);

  final Article model;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        context.isLargeScreen
            ? context.provider.childBeamerKey.currentState?.routerDelegate
                .beamToNamed('/${model.link}')
            : context.beamToNamed('/${model.link}');
      },
      child: AnimatedBuilder(
          animation: context.isLargeScreen
              ? context.provider.childBeamerKey.currentState!.routerDelegate
              // Prevent uneccessary build when in small screen mode
              : Listenable.merge([]),
          builder: (context, _) {
            return Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 29, 29, 29),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(-3, 2),
                    spreadRadius: 1,
                    blurRadius: 3,
                    color: const Color.fromARGB(255, 0, 0, 0)!,
                  )
                ],
                borderRadius: BorderRadius.circular(7),
                border: Border.all(
                  color: _isSelected(context) ? lightYellow : Colors.transparent,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                model.title,
                                style: textTheme.titleLarge,
                              ),
                            ),
                            const SizedBox(height: 4),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  bool _isSelected(BuildContext context) {
    if (!context.isLargeScreen) return false;

    final params = (context.provider.childBeamerKey.currentState
            ?.currentBeamLocation.state as BeamState)
        .pathParameters;

    return params['link'] == model.link;
  }

  Widget _buildChip(
    BuildContext context,
    String text, {
    Color? color,
    double? horizontalPad,
    FontWeight? fontWeight,
  }) =>
      FittedBox(
        fit: BoxFit.scaleDown,
        child: Container(
          decoration: BoxDecoration(
            color: color ?? Colors.grey[100],
            borderRadius: BorderRadius.circular(15),
          ),
          padding:
              EdgeInsets.symmetric(vertical: 4, horizontal: horizontalPad ?? 8),
          alignment: Alignment.center,
          child: Text(
            text,
            style: Theme.of(context).chipTheme.labelStyle!.copyWith(
                  fontWeight: fontWeight,
                ),
          ),
        ),
      );
}
