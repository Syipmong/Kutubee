import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BrowseBooksScreen extends StatelessWidget {
  const BrowseBooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Browse Books'),
      ),
      body: BookList(),
    );
  }
}

class BookList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('books').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final List<DocumentSnapshot> documents = snapshot.data!.docs;
        return ListView.builder(
          itemCount: documents.length,
          itemBuilder: (context, index) {
            final Map<String, dynamic> data = documents[index].data() as Map<String, dynamic>;
            return ListTile(
              title: Text(data['title'] ?? 'No Title'),
              subtitle: Text(data['author'] ?? 'No Author'),
              // Add more fields like description, availability status, etc.
            );
          },
        );
      },
    );
  }
}
