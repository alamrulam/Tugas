<<<<<<< HEAD
// lib/main.dart

import 'dart:convert';
import 'package:api/add_list.dart';
import 'package:api/modela.dart';
import 'package:api/user_detail.dart'; // Import halaman detail
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
=======
import 'package:flutter/material.dart'; import 'package:http/http.dart' as http;
import 'dart:convert';
import 'model.dart';
import 'add_user.dart';
>>>>>>> f217a21ef8b49341c8e2f520261b97d07d8fb642

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reqres API Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
<<<<<<< HEAD
  late Future<UserResponse> futureUsers;

  Future<UserResponse> fetchUsers() async {
    var api = "https://reqres.in/api/users?page=2";
    final response = await http.get(Uri.parse(api));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return UserResponse.fromJson(data);
    } else {
      throw Exception("Failed to load users");
=======
  Future<List<User>> _fetchUsers() async {
    final response = await http.get(Uri.parse('https://reqres.in/api/users'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final users = (jsonData['data'] as List).map((jsonUser) => User.fromJson(jsonUser)).toList();
      return users;
    } else {
      throw Exception('Failed to load users');
>>>>>>> f217a21ef8b49341c8e2f520261b97d07d8fb642
    }
  }

  @override
<<<<<<< HEAD
  void initState() {
    super.initState();
    futureUsers = fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User List")),
      body: FutureBuilder<UserResponse>(
        future: futureUsers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.data.length,
              itemBuilder: (context, index) {
                var user = snapshot.data!.data[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.avatar),
                    ),
                    title: Text("${user.firstName} ${user.lastName}"),
                    subtitle: Text(user.email),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserDetailPage(userId: user.id),
                        ),
                      );
                    },
=======
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reqres API Demo'),
      ),
      body: FutureBuilder<List<User>>(
        future: _fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('An error occurred: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final users = snapshot.data;

            return ListView.builder(
              itemCount: users!.length,
              itemBuilder: (context, index) {
                final user = users[index];

                return ListTile(
                  title: Text('${user.firstName} ${user.lastName}'),
                  subtitle: Text(user.email),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user.avatar),
>>>>>>> f217a21ef8b49341c8e2f520261b97d07d8fb642
                  ),
                );
              },
            );
          } else {
<<<<<<< HEAD
            return const Center(child: Text("No data found"));
=======
            return Center(child: Text('Failed to load users'));
>>>>>>> f217a21ef8b49341c8e2f520261b97d07d8fb642
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
<<<<<<< HEAD
            MaterialPageRoute(builder: (context) => const AddUserPage()),
=======
            MaterialPageRoute(builder: (context) => AddUserPage()),
>>>>>>> f217a21ef8b49341c8e2f520261b97d07d8fb642
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
