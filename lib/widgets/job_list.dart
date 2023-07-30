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
              return Container(
                color: const Color.fromARGB(255, 20, 20, 20),
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (c, index) => JobCard(
                    model: snapshot.data![index],
                  ),
                ),
              );
            } else {
              return const Text("Connection error");
            }
          } else if (snapshot.hasError) {
            return const Text('Error');
          } else {
            return Container(
                alignment: Alignment.center,
                child: const SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    backgroundColor: Color.fromARGB(255, 20, 20, 20),
                  ),
                ));
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
                .beamToNamed('/${model.id}')
            : context.beamToNamed('/${model.id}');
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
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(-3, 2),
                    spreadRadius: 1,
                    blurRadius: 3,
                    color: Color.fromARGB(255, 0, 0, 0),
                  )
                ],
                borderRadius: BorderRadius.circular(7),
                border: Border.all(
                  color:
                      _isSelected(context) ? lightYellow : Colors.transparent,
                ),
              ),
              child: Text(
                model.title,
                style: textTheme.titleLarge,
                overflow: TextOverflow.ellipsis,
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

    return params['id'] == model.id.toString();
  }
}
