import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kutubee/screens/admin.dart';
import 'package:kutubee/screens/bottomnavigation.dart';
import 'package:kutubee/screens/populacategories.dart';
import 'package:kutubee/screens/profilescreen.dart';
import 'package:kutubee/screens/recommendedbooks.dart';
import 'package:kutubee/screens/search.dart';
import 'books.dart';
import 'trendingstories.dart';




class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }



  @override
  Widget build(BuildContext context) {
    // lets get some data from our firestore
    final user = FirebaseAuth.instance.currentUser?.email;
  // geting a user document from a collection in firestore
    final user_icon = FirebaseFirestore.instance
        .collection('users').doc(FirebaseAuth.instance.currentUser!.email).get();
    // switch(_selectedIndex){
    //   case 0:
    //     Navigator.pushNamed(context, '/popular');
    //     break;
    //   case 1:
    //     Navigator.pushNamed(context, '/search');
    //     break;
    //   case 2:
    //     Navigator.pushNamed(context, '/allbooks');
    //     break;
    //   case 3:
    //     Navigator.pushNamed(context, '/profile');
    //     break;
    // }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kutubee',
          style: GoogleFonts.roboto(
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              );
            },
          ),
          IconButton(
            //we will get the user profile image from firebase storage saved in firestore as a photo_url
            icon:  const Icon(Icons.account_circle),
            onPressed: () {
              // Handle account action
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileSetupScreen()),
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
      body: ListView(
        children: [
          const Padding(
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
          const Padding(
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
                SizedBox(
                  height: 400, // Set a fixed height or use Expanded
                  child: PopularCategories(),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Trending Stories',
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10.0),
                SizedBox(
                  height: 200, // Set a fixed height or use Expanded
                  child: TrendingStories(),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Books',
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10.0),
                SizedBox(
                  height: 600, // Set a fixed height or use Expanded
                  child: AllBookView(),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text('Home'),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.search),
            title: const Text('Search'),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.favorite),
            title: const Text('Favorites'),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.person),
            title: const Text('Profile'),
          ),
        ],
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
      const SnackBar(content: Text('Error Signing Out ')),
    );
  }
}
