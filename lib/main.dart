import 'dart:convert';

import 'package:api/add_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Post {
  Post({
    required this.userId,
    required this.title,
    required this.body,
  });

  final int userId;
  final String title;
  final String body;

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      title: json['title'],
      body: json['body'],
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Post>> feachDataAPI() async {
    var api = "https://jsonplaceholder.typicode.com/posts";
    final respone = await http.get(Uri.parse(api));

    if (respone.statusCode == 200) {
      var data = json.decode(respone.body);

      return List.generate(data.length, (index) {
        return Post.fromJson(data[index]);
      } );
    } else {
      throw Exception("Error");
    }
  }

  @override
  void initState() {
    feachDataAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Post>>(
        future: feachDataAPI(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            final data = snapshot.data;

            return ListView.builder(
              itemCount: data!.length,
              itemBuilder: (context, index) {
                var item = data[index];

                return Card(
                  child: ListTile(
                    leading: Text("${item.userId}"),
                    title: Text(item.title),
                    subtitle: Text(item.title),
                  ),
                );
              },
            );
            // return Center(
            //   child: Card(
            //     child: ListTile(
            //       leading: Text("${item.userId}"),
            //       title: Text(snapshot.data!.title),
            //       subtitle: Text(snapshot.data!.title),
            //     ),
            //   ),
            // );
          } else if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          } else {
            return Text("");
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,MaterialPageRoute(builder: (context) => AddListPage(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
