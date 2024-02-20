import 'package:flutter/material.dart';


class PopularCategories extends StatelessWidget {
  const PopularCategories({super.key});

  @override
  Widget build(BuildContext context) {
    // Replace this with actual data or a placeholder widget
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Adjust the number of columns as needed
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1.5, // Adjust the aspect ratio as needed
      ),
      itemCount: 6, // Replace with the actual number of categories
      itemBuilder: (context, index) {
        // Return a widget for each category
        return Container(
          color: Colors.green, // Placeholder color
          child: Center(
            child: Text('Category $index'), // Placeholder text
          ),
        );
      },
    );
  }
}
