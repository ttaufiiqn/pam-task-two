import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Help')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'How to Use This App',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              '1. Members: View a list of all members and their details.',
              style: TextStyle(fontSize: 13),
            ),
            const Text(
              '2. Stopwatch: Use the stopwatch feature to time events.',
              style: TextStyle(fontSize: 13),
            ),
            const Text(
              '3. Recommendations: Get articles recommendations.',
              style: TextStyle(fontSize: 13),
            ),
            const Text(
              '4. Favorites: Access your favorite items quickly.',
              style: TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 20),
            const Text(
              'To log out, click the button below:',
              style: TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  textStyle: const TextStyle(fontSize: 14),
                  elevation: 5,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Confirm Logout"),
                        content:
                            const Text("Are you sure you want to log out?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/login');
                            },
                            child: const Text("Logout"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text('Logout'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.help), label: 'Help'),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          }
        },
      ),
    );
  }
}
