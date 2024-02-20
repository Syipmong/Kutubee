import 'package:flutter/material.dart';

class PopularCategories extends StatelessWidget {
  const PopularCategories({Key? key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {'title': 'Adventure', 'image': 'assets/images/test1.jpg'},
      {'title': 'Fantasy', 'image': 'assets/images/test1.jpg'},
      {'title': 'Romance', 'image': 'assets/images/test1.jpg'},
      {'title': 'Mystery', 'image': 'assets/images/test1.jpg'},
      {'title': 'Thriller', 'image': 'assets/images/test1.jpg'},
      {'title': 'Science Fiction', 'image': 'assets/images/test1.jpg'},
    ];

    return GridView.builder(
      padding: EdgeInsets.all(16.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 16.0,
        childAspectRatio: 0.75,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return GestureDetector(
          onTap: () {

          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
                  child: Image.asset(
                    category['image'],
                    fit: BoxFit.cover,
                    height: 120.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    category['title'],
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
