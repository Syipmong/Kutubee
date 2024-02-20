import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kutubee/screens/populacategories.dart';
import 'package:kutubee/screens/profilescreen.dart';
import 'package:kutubee/screens/recommendedbooks.dart';
import 'trendingstories.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser?.email;
    return Scaffold(
      appBar: AppBar(
        // title: Text(user ?? 'Guest', style: TextStyle(
        //   fontSize: 15,
        //   color: Colors.blueAccent
        //
        // ),
        // ),
        title: Text('e-library', style: GoogleFonts.roboto(),),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Handle search action
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              // Handle account action
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ProfileSetupScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
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
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'Recommended Stories',
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  SizedBox(
                    height: 200,
                    child: RecommendedBooks(),
                  ),
                ],
              ),
            ),


            // Popular Categories Section with dummy data
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'Popular Categories',
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  // Ensure PopularCategories widget has a bounded height
                  SizedBox(
                    height: 200, // Set a fixed height or use Expanded
                    child: PopularCategories(),
                  ),
                ],
              ),
            ),


            // Trending Stories Section with dummy data
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'Trending Stories',
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  // Ensure TrendingStories widget has a bounded height
                  SizedBox(
                    height: 200, // Set a fixed height or use Expanded
                    child: TrendingStories(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _signOut(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed('/auth');
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error Signing Out ')),
    );
  }
}
