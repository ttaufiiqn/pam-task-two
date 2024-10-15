import 'package:flutter/material.dart';

import '../widgets/favorite_list.dart';
import '../widgets/member_list.dart';
import '../widgets/recommendation_list.dart';
import '../widgets/stopwatch.dart';
import 'help_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: GridView.count(
          crossAxisCount: 2, // Number of columns in the grid
          mainAxisSpacing: 20, // Spacing between rows
          crossAxisSpacing: 20, // Spacing between columns
          children: [
            _buildGridButton(context, 'Members', Icons.people, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MemberList()),
              );
            }),
            _buildGridButton(context, 'Stopwatch', Icons.timer, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StopwatchWidget()),
              );
            }),
            _buildGridButton(context, 'Recommendations', Icons.star, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RecommendationList()),
              );
            }),
            _buildGridButton(context, 'Favorites', Icons.favorite, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoriteList()),
              );
            }),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.help), label: 'Help'),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HelpPage()),
            );
          }
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  Widget _buildGridButton(BuildContext context, String title, IconData icon,
      VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(20),
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 40,
            color: Colors.blue,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 12, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
