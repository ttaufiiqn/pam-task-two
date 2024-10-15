import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/recommendation.dart';

class FavoriteList extends StatefulWidget {
  const FavoriteList({super.key});

  @override
  _FavoriteListState createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  List<Recommendation> favoriteRecommendations = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoriteData = prefs.getStringList('favorites');

    if (favoriteData != null && favoriteData.isNotEmpty) {
      setState(() {
        favoriteRecommendations = favoriteData.map((data) {
          final parts = data.split('::');
          return Recommendation(
            title: parts[0],
            image: parts[1],
            url: parts.length > 2 ? parts[2] : '',
          );
        }).toList();
      });
    } else {
      print('No favorites found');
    }
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: favoriteRecommendations.isEmpty
          ? const Center(child: Text('No favorites added yet.'))
          : ListView.builder(
              itemCount: favoriteRecommendations.length,
              itemBuilder: (context, index) {
                final recommendation = favoriteRecommendations[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () {
                      if (recommendation.url.isNotEmpty) {
                        _launchURL(recommendation.url);
                      }
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(recommendation.image),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            recommendation.title,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
