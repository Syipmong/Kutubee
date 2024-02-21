import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart'; // Import the image_picker package

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseStorage _storage = FirebaseStorage.instance;
final ImagePicker _picker = ImagePicker(); // Create an instance of ImagePicker

Future<void> addBook(Map<String, dynamic> bookData) async {
  try {
    await _firestore.collection('books').add(bookData);
    print('Book added successfully.');
  } catch (e) {
    print('Error adding book: $e');
  }
}

Stream<QuerySnapshot> getAllBooks() {
  return _firestore.collection('books').snapshots();
}

Future<void> updateBook(String bookId, Map<String, dynamic> bookData) async {
  try {
    await _firestore.collection('books').doc(bookId).update(bookData);
    print('Book updated successfully.');
  } catch (e) {
    print('Error updating book: $e');
  }
}

Future<void> deleteBook(String bookId) async {
  try {
    await _firestore.collection('books').doc(bookId).delete();
    print('Book deleted successfully.');
  } catch (e) {
    print('Error deleting book: $e');
  }
}

Future<String?> uploadImage() async {
  try {
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return null; // User canceled image selection

    final Reference ref = _storage.ref().child('book_images/${DateTime.now().millisecondsSinceEpoch}');
    final UploadTask uploadTask = ref.putFile(File(pickedImage.path));
    final TaskSnapshot taskSnapshot = await uploadTask;
    final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  } catch (e) {
    print('Error uploading image: $e');
    return null;
  }
}

Future<void> deleteImage(String imageUrl) async {
  try {
    await _storage.refFromURL(imageUrl).delete();
    print('Image deleted successfully.');
  } catch (e) {
    print('Error deleting image: $e');
  }
}
