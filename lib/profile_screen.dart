import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'api_service.dart';

class ProfileScreen extends StatelessWidget {
  void logout(BuildContext context) async {
    await ApiService.logoutUser();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String>>(
      future: ApiService.getUserData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(title: Text('Profile')),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text('Email: ${snapshot.data!['email']}'),
                  Text('Plan: ${snapshot.data!['plan']}'),
                  SizedBox(height: 20),
                  ElevatedButton(onPressed: () => logout(context), child: Text('Logout')),
                ],
              ),
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
