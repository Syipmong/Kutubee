import 'package:flutter/material.dart';

class TrendingStories extends StatelessWidget {
   TrendingStories({Key? key}) : super(key: key);


  final List<String> trendingTitles = [
    'Story 1',
    'Story 2',
    'Story 3',
    'Story 4',
    'Story 5',
  ];

  final List<String> trendingDescriptions = [
    'Description of Story 1',
    'Description of Story 2',
    'Description of Story 3',
    'Description of Story 4',
    'Description of Story 5',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: trendingTitles.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(trendingTitles[index]),
          subtitle: Text(trendingDescriptions[index]),
        );
      },
    );
  }
}
