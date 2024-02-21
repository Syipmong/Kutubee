import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class AdminCombinedScreen extends StatefulWidget {
  const AdminCombinedScreen({Key? key}) : super(key: key);

  @override
  State<AdminCombinedScreen> createState() => _AdminCombinedScreenState();
}

class _AdminCombinedScreenState extends State<AdminCombinedScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentIndex == 0 ? 'Admin Panel' : _currentIndex == 1 ? 'Add New Book' : 'All Books'),
      ),
      body: PageView(
        children: [
          AdminScreen(),
          AddBookScreen(),
          ViewAllBooksScreen(),
        ],
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.admin_panel_settings),
            label: 'Admin',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Book',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'All Books',
          ),
        ],
      ),
    );
  }
}

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () {
              // Navigate directly to the AddBookScreen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddBookScreen()),
              );
            },
            child: Text('Add New Book'),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ViewAllBooksScreen()),
              );
            },
            child: Text('View All Books'),
          ),
        ],
      ),
    );
  }
}

class AddBookScreen extends StatefulWidget {
  @override
  _AddBookScreenState createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  File? _image;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          _image != null
              ? Image.file(
            _image!,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          )
              : Icon(
            Icons.image,
            size: 200,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: _getImage,
            child: Text('Pick Image'),
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(12.0),
            ),
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _authorController,
            decoration: InputDecoration(
              labelText: 'Author',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(12.0),
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              _addBook();
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16.0),
            ),
            child: Text('Add Book'),
          ),
        ],
      ),
    );
  }

  void _addBook() {
    if (_titleController.text.isNotEmpty &&
        _authorController.text.isNotEmpty &&
        _image != null) {
      // Upload the image and add book data to Firestore
      _uploadImageAndAddBook();
    } else {
      // Display a snackbar if any field is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill out all fields and pick an image')),
      );
    }
  }

  Future<void> _uploadImageAndAddBook() async {
    try {
      // Add book data to Firestore
      Navigator.pop(context); // Navigate back to AdminScreen
    } catch (e) {
      // Handle error uploading image
      print('Error uploading image: $e');
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    super.dispose();
  }
}

class ViewAllBooksScreen extends StatelessWidget {
  const ViewAllBooksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Books'),
      ),
      body: AllBooks(),
    );
  }
}

class AllBooks extends StatelessWidget {
  const AllBooks({Key? key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('books').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final List<DocumentSnapshot> books = snapshot.data!.docs;
        return ListView.builder(
          itemCount: books.length,
          itemBuilder: (context, index) {
            final book = books[index].data() as Map<String, dynamic>;
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(book['imageUrl']), // Use the image URL from Firestore
              ),
              title: Text(book['title']),
              subtitle: Text('Author: ${book['author']}'),
            );
          },
        );
      },
    );
  }
}
