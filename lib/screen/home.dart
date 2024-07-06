import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final u = users[index];
          final email = u['email'];
          return ListTile(
            title: Text(email),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: fetchUser),
    );
  }

  void fetchUser() async {
    print('fetching');
    final url = 'https://randomuser.me/api/?results=10';
    final rs = Uri.parse(url);
    final response = await http.get(rs);
    if (response.statusCode == 200) {
      final body = response.body;
      final user = jsonDecode(body);
      setState(() {
        users = user['results'];
      });
      print('fetched');
    } else {
      print('Failed to load users');
    }
  }
}
