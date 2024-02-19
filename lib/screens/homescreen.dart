// home_screen.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kutubee/screens/browsebookscreen.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to MyBooks',),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _signOut(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            // Add more widgets as needed
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome back, ${FirebaseAuth.instance.currentUser!.displayName}!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          // Add user profile image, name, and other details here
          // You can use CircleAvatar or similar widgets for the profile image
        ],
      ),
    );
  }

  Widget _buildUserPosts() {
    // Placeholder for user's posts
    return Container(
      color: Colors.grey[200],
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Text(
            'Your Posts',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          // Add user's posts here
          // You can use ListTile or similar widgets to display each post
        ],
      ),
    );
  }

  Widget _buildFeeds() {
    // Placeholder for feeds
    return Container(
      color: Colors.grey[300],
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Text(
            'Feeds',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          // Add feeds here
          // You can use ListTile or similar widgets to display each feed item
        ],
      ),
    );
  }

  void _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacementNamed('/auth');
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}
