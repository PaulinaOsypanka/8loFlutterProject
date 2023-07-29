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
              title: Text(
                model.title,
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
                padding: const EdgeInsets.all(24).copyWith(top: 35),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  model.content,
                  style: textTheme.bodyMedium,
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
    const dot =
        Expanded(child: CircleAvatar(radius: 2, backgroundColor: Colors.grey));

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 29, 29, 29),
              borderRadius: BorderRadius.circular(7),
            ),
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(top: 35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 36),
                Text(
                  "${model.title}\n",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(model.title),
                      ...[dot, Text(model.author), dot],
                      Text(model.date),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
