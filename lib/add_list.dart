import 'dart:convert';
// ignore: unused_import
import 'package:api/modela.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class AddUserPage extends StatefulWidget {
  const AddUserPage({Key? key}) : super(key: key);

  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController jobController = TextEditingController();

  Future<void> addUser(String name, String job) async {
    var apiUrl = Uri.parse('https://reqres.in/api/users');
    
    var response = await http.post(
      apiUrl,
      body: json.encode({
        'name': name,
        'job': job,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 201) {
      var responseData = json.decode(response.body);
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Success'),
          content: Text('User added successfully with ID: ${responseData['id']}'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to add user. Please try again later.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Name'),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text('Job'),
            TextFormField(
              controller: jobController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                addUser(nameController.text, jobController.text);
              },
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}