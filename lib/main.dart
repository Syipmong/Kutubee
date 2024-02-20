import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kutubee/screens/authentication.dart';
import 'package:kutubee/screens/email_password_login_screen.dart';
import 'package:kutubee/screens/homescreen.dart';
import 'package:kutubee/firebase_options.dart';
import 'package:kutubee/screens/profilescreen.dart';
import 'package:provider/provider.dart';
import 'screens/createaccount.dart';
import 'screens/forgotpassword.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyBooksApp());
}

class MyBooksApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(), // Provide UserProvider
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Kutubee',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: _handleAuth(), // Use _handleAuth for initial route
        routes: {
          '/auth': (context) => AuthenticationScreen(),
          '/create_account': (context) => CreateAccountScreen(),
          '/forgot_password': (context) => ForgotPasswordScreen(),
          '/email_password_login': (context) => EmailPasswordLoginScreen(),
          '/home': (context) => HomeScreen(),
          '/profile': (context) => ProfileSetupScreen()
        },
      ),
    );
  }

  Widget _handleAuth() {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (snapshot.hasData) {
            // User is signed in
            return HomeScreen();
          } else {
            // User is not signed in
            return AuthenticationScreen();
          }
        }
      },
    );
  }
}

class UserProvider extends ChangeNotifier {
  String? userName;

  void setUserName(String name) {
    userName = name;
    notifyListeners();
  }
}
