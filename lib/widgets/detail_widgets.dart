import 'package:flutter/material.dart';
import 'package:lo_news/extensions.dart';

import '../article.dart';

class JobDetailWidget extends StatelessWidget {
  const JobDetailWidget({Key? key, required this.model}) : super(key: key);

  final Article model;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: context.isLargeScreen
          ? null
          : AppBar(
              iconTheme: const IconThemeData(
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              title: Text(
                model.title,
                overflow: TextOverflow.ellipsis,
              ),
            ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(255, 20, 20, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _CompanyInfoWidget(model: model),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  model.content,
                  style: textTheme.bodyMedium,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: List.generate(model.images.length, (index) {
                    return Image.network(
                      model.images[index].link,
                    );
                  }),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 359),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CompanyInfoWidget extends StatelessWidget {
  const _CompanyInfoWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  final Article model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 29, 29, 29),
              borderRadius: BorderRadius.circular(7),
            ),
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 6),
                Column(
                  children: [
                    Text(
                      model.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    model.author,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    model.date,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 6),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
