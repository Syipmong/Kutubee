import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmailPasswordLoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  EmailPasswordLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email/Password Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _signInWithEmailPassword(context);
                },
                child: const Text('Sign In'),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    // Navigate to the screen for creating a new account
                    Navigator.of(context).pushNamed('/create_account');
                  },
                  child: const Text('Create Account'),
                ),
                const SizedBox(width: 20),
                TextButton(
                  onPressed: () {
                    // Navigate to the screen for resetting password
                    Navigator.of(context).pushNamed('/forgot_password');
                  },
                  child: const Text('Forgot Password'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _signInWithEmailPassword(BuildContext context) async {
    try {
      final String email = emailController.text.trim();
      final String password = passwordController.text.trim();

      // Sign in with email/password
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Navigate to home screen after successful login
      Navigator.of(context).pushReplacementNamed('/home');
    } catch (e) {
      // Handle errors
      print('Email/Password Sign-In Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to sign in with email/password. Please try again.'),
        ),
      );
    }
  }
}
