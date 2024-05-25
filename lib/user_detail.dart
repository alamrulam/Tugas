// lib/user_detail.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'modela.dart';

class UserDetailPage extends StatefulWidget {
  final int userId;

  const UserDetailPage({required this.userId, Key? key}) : super(key: key);

  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  late Future<User> futureUser;

  Future<User> fetchUserDetail(int userId) async {
    var api = "https://reqres.in/api/users/$userId";
    final response = await http.get(Uri.parse(api));

    if (response.statusCode == 200) {
      var data = json.decode(response.body)['data'];
      return User.fromJson(data);
    } else {
      throw Exception("Failed to load user");
    }
  }

  @override
  void initState() {
    super.initState();
    futureUser = fetchUserDetail(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User Detail")),
      body: FutureBuilder<User>(
        future: futureUser,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            var user = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(user.avatar),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text("ID: ${user.id}", style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  Text("Name: ${user.firstName} ${user.lastName}", style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  Text("Email: ${user.email}", style: const TextStyle(fontSize: 18)),
                ],
              ),
            );
          } else {
            return const Center(child: Text("No data found"));
          }
        },
      ),
    );
  }
}
