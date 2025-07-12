import 'package:flutter/material.dart';
import 'api_service.dart';

class SubscriptionScreen extends StatelessWidget {
  final TextEditingController planController = TextEditingController();

  void upgrade(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email') ?? '';
    final plan = planController.text;
    await ApiService.upgradePlan(email, plan);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Plan upgraded to $plan')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Subscription')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(controller: planController, decoration: InputDecoration(labelText: 'Enter plan')),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () => upgrade(context), child: Text('Upgrade')),
          ],
        ),
      ),
    );
  }
}
