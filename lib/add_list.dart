// ignore_for_file: unused_import

import 'dart:convert';

import 'package:api/modela.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddListPage extends StatefulWidget {
  const AddListPage({super.key});

  @override
  State<AddListPage> createState() => _AddListPageState();
}

class _AddListPageState extends State<AddListPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  TextEditingController idController = TextEditingController();

  Future<void> addList(int id, String title, String body) async {
    var api = "https://jsonplaceholder.typicode.com/posts";

    final response = await http.post(Uri.parse(api),
        body: json.encode(
          {
            "title": title,
            "body": body,
            "userid": id,
          },
        ),
        headers: {"Content-type": 'application/json; charset=Utf-8'});

    if (response.statusCode >= 200) {
      print(response.body);
    } else {
      print("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text("id"),
              TextFormField(
                controller: idController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
              SizedBox(height: 10),
              Text("title"),
              TextFormField(
                controller: titleController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
              SizedBox(height: 30),
              Text("body"),
              TextFormField(
                controller: bodyController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    addList(
                      int.parse(idController.text),
                      titleController.text,
                      bodyController.text,
                    );
                  },
                  child: Text("Add"),
                ),
              )
            ],
          ),
        ));
  }
}