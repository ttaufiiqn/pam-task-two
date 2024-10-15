import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/recommendation.dart';

class RecommendationList extends StatefulWidget {
  const RecommendationList({super.key});

  @override
  _RecommendationListState createState() => _RecommendationListState();
}

class _RecommendationListState extends State<RecommendationList> {
  final List<Recommendation> recommendations = [
    Recommendation(
      title: "Growth Mindset Feedback",
      image:
          "https://www.innerfokus.com/cdn/shop/articles/growth_mindset_featured_image.jpg?v=1712693521",
      url: "https://www.workhuman.com/blog/growth-mindset-feedback/",
    ),
    Recommendation(
      title: "Time Management Is About More Than Life Hacks",
      image:
          "https://cdn.prod.website-files.com/634681057b887c6f4830fae2/6367ddbbfa8aebba50fd824c_6259f7cc35ba017efda63bee_Time-Management-Tips.webp",
      url:
          "https://hbr.org/2020/01/time-management-is-about-more-than-life-hacks",
    ),
    Recommendation(
      title: "In Uncertain Times, the Best Strategy Is Adaptability",
      image:
          "https://i0.wp.com/www.goodwin.edu/enews/wp-content/uploads/2020/04/chris-lawton-5IHz5WhosQE-unsplash-1-scaled.jpg?resize=1920%2C768&ssl=1",
      url:
          "https://hbr.org/2022/08/in-uncertain-times-the-best-strategy-is-adaptability",
    ),
    Recommendation(
      title: "Project Management Phases",
      image:
          "https://i0.wp.com/mwangazaafricaconsultants.com/wp-content/uploads/2022/06/project-management-phases-.png?fit=1024%2C768&ssl=1",
      url: "https://www.forbes.com/advisor/business/project-management-phases/",
    ),
    Recommendation(
      title: "Why Personal Branding Is Important and How To Build Yours",
      image:
          "https://images.ctfassets.net/joi3nje8wm6a/tmITfXcTQsPW1YBLACfLD/7ecaec6ddbf8d825a12a68f3031dc310/1__What_is_a_personal_brand.jpg?fm=webp",
      url:
          "https://www.forbes.com/sites/karadennison/2022/11/28/why-personal-branding-is-important-and-how-to-build-yours/?sh=24a420886969",
    ),
  ];

  List<String> favoriteTitles = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      favoriteTitles = prefs.getStringList('favorites') ?? [];
    });
  }

  Future<void> _addFavorite(String title, String imageUrl, String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String favoriteData = '$title::$imageUrl::$url';
    if (!favoriteTitles.contains(favoriteData)) {
      favoriteTitles.add(favoriteData);
      await prefs.setStringList('favorites', favoriteTitles);
      setState(() {}); // Update the UI after adding favorite
    }
  }

  Future<void> _removeFavorite(String title) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String favoriteData = favoriteTitles
        .firstWhere((data) => data.startsWith(title), orElse: () => '');
    if (favoriteTitles.contains(favoriteData)) {
      favoriteTitles.remove(favoriteData);
      await prefs.setStringList('favorites', favoriteTitles);
      setState(() {}); // Update the UI after removing favorite
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
      appBar: AppBar(title: const Text('Recommendations')),
      body: ListView.builder(
        itemCount: recommendations.length,
        itemBuilder: (context, index) {
          final recommendation = recommendations[index];
          bool isFavorite = favoriteTitles
              .any((data) => data.startsWith(recommendation.title));

          return Card(
            margin: const EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                _launchURL(recommendation.url);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(recommendation.image),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            recommendation.title,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : null,
                          ),
                          onPressed: () {
                            if (!isFavorite) {
                              _addFavorite(
                                  recommendation.title,
                                  recommendation.image,
                                  recommendation.url); // Pass the URL
                            } else {
                              _removeFavorite(recommendation.title);
                            }
                          },
                        ),
                      ],
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
