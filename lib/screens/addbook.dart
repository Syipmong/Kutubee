import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kutubee/screens/managingbooks.dart';
import 'package:image_picker/image_picker.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Book'),
      ),
      body: Padding(
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
                : const Icon(
              Icons.image,
              size: 200,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _getImage,
              child: const Text('Pick Image'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(12.0),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _authorController,
              decoration: const InputDecoration(
                labelText: 'Author',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(12.0),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _addBook();
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: const Text('Add Book'),
            ),
          ],
        ),
      ),
    );
  }

  void _addBook() {
    if (_titleController.text.isNotEmpty && _authorController.text.isNotEmpty && _image != null) {
      // Upload the image and add book data to Firestore
      _uploadImageAndAddBook();
    } else {
      // Display a snackbar if any field is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill out all fields and pick an image')),
      );
    }
  }

  Future<void> _uploadImageAndAddBook() async {
    try {
      final imageUrl = await uploadImage();
      addBook({
        'title': _titleController.text,
        'author': _authorController.text,
        'imageUrl': imageUrl,
      });
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
