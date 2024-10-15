import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Welcome to the Home Page!'),
            ElevatedButton(
              onPressed: () {
                // Add your action here
              },
              child: const Text('Perform an Action'),
            ),
          ],
        ),
      ),
    );
  }
}
