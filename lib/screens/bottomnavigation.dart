// import 'package:dot_navigation_bar/dot_navigation_bar.dart';
// import 'package:flutter/material.dart';
//
// class BottomNavBar extends StatefulWidget {
//   const BottomNavBar({Key? key}) : super(key: key);
//
//   @override
//   State<BottomNavBar> createState() => _BottomNavBarState();
// }
//
// class _BottomNavBarState extends State<BottomNavBar> {
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 200,
//       child: DotNavigationBar(
//         currentIndex: 0, // Set the initial selected index
//         onTap: (index) {
//           // Handle button tap
//           switch (index) {
//             case 0:
//             // Navigate to the home screen
//             // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
//               break;
//             case 1:
//             // Navigate to the search screen
//             // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
//               break;
//             case 2:
//             // Navigate to the books screen
//             // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => BooksScreen()));
//               break;
//             case 3:
//             // Navigate to the favorites screen
//             // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => FavoritesScreen()));
//               break;
//             case 4:
//             // Navigate to the profile screen
//             // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
//               break;
//             default:
//               break;
//           }
//         },
//         items:  [
//           /// First button
//           DotNavigationBarItem(
//             icon: Icon(Icons.home),
//             selectedColor: Colors.purple,
//           ),
//
//           /// Second button
//           DotNavigationBarItem(
//             icon: Icon(Icons.search),
//             selectedColor: Colors.pink,
//           ),
//
//
//           DotNavigationBarItem(
//             icon: Icon(Icons.favorite),
//             selectedColor: Colors.teal,
//           ),
//
//           /// Fifth button
//           DotNavigationBarItem(
//             icon: Icon(Icons.person),
//             selectedColor: Colors.blue,
//           ),
//         ],
//       ),
//     );
//   }
// }
