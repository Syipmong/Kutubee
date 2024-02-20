import 'package:flutter/material.dart';

class RecommendedBooks extends StatelessWidget {
  const RecommendedBooks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2, // Number of columns
      crossAxisSpacing: 10.0, // Spacing between columns
      mainAxisSpacing: 10.0, // Spacing between rows
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(), // Disable scrolling
      children: List.generate(
        6, // Number of items
            (index) => GestureDetector(
          onTap: () {
            // Handle item tap
          },
          child: Container(
            color: Colors.blueGrey,
            child: Center(
              child: Text(
                'Book ${index + 1}',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
