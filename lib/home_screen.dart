import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'subscription_screen.dart';
import 'profile_screen.dart';
import 'api_service.dart';

class HomeScreen extends StatelessWidget {
  Future<List<dynamic>> _getMovies() => ApiService.fetchMovies();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies'),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileScreen()));
            },
          ),
          IconButton(
            icon: Icon(Icons.payment),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => SubscriptionScreen()));
            },
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _getMovies(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: snapshot.data!.map((movie) {
                return ListTile(
                  leading: Image.network(movie['thumbnail']),
                  title: Text(movie['title']),
                );
              }).toList(),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load movies'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
