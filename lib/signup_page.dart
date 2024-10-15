  import 'package:flutter/material.dart';
  import 'package:firebase_auth/firebase_auth.dart';

  class SignupPage extends StatefulWidget {
    @override
    _SignupPageState createState() => _SignupPageState();
  }

  class _SignupPageState extends State<SignupPage> {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    Future<void> _signup() async {
      try {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        // Navigate to the home page or another page on successful signup
        Navigator.pushReplacementNamed(context, '/home');
      } catch (e) {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: Text('Sign Up')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _signup,
                child: Text('Sign Up'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Text('Already have an account? Login'),
              ),
            ],
          ),
        ),
      );
    }
  }
