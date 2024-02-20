import 'package:flutter/material.dart';

class RecommendedBooks extends StatelessWidget {
  const RecommendedBooks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> books = [
      {'title': 'Book 1', 'author': 'Author 1', 'image': 'assets/images/book1.jpg'},
      {'title': 'Book 2', 'author': 'Author 2', 'image': 'assets/images/book1.jpg'},
      {'title': 'Book 3', 'author': 'Author 3', 'image': 'assets/images/book1.jpg'},
      {'title': 'Book 4', 'author': 'Author 4', 'image': 'assets/images/book1.jpg'},
      {'title': 'Book 5', 'author': 'Author 5', 'image': 'assets/images/book1.jpg'},
      {'title': 'Book 6', 'author': 'Author 6', 'image': 'assets/images/book1.jpg'},
    ];

    return SizedBox(
      height: 200.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                // Handle book tap
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 3,
                child: SizedBox(
                  width: 160.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
                          child: Image.asset(
                            book['image'],
                            fit: BoxFit.cover,
                            height: 120.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              book['title'],
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              'by ${book['author']}',
                              style: TextStyle(fontSize: 14.0),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
