// lib/screens/profile_screen.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: FutureBuilder(
        future: fetchUserProfile(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data.name.toString());
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }

  Future fetchUserProfile() async {
    final response = await http.get(
      Uri.parse('https://api.example.com/profile'),
    );
    return jsonDecode(response.body);
  }
}
