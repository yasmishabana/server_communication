import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:server_communication/direct_call/direct_with_api/loginpage.dart';
import 'package:server_communication/direct_call/model/postmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Post>> fetchPost() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    return parsed.map<Post>((json) => Post.fromMap(json)).toList();
  } else {
    throw Exception('Failed to load album');
  }
}

class ListDataExample extends StatefulWidget {
  @override
  _ListDataExampleState createState() => _ListDataExampleState();
}

class _ListDataExampleState extends State<ListDataExample> {
  late Future<List<Post>> futurePost;
  @override
  void initState() {
    super.initState();
    futurePost = fetchPost();
    _loadUsername();
  }

  String? username;

  void _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      username = prefs.getString('username');
    });
    log("username = $username");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('username = $username'),
      ),
      body: FutureBuilder<List<Post>>(
        future: futurePost,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            log("length == ${snapshot.data!.length}");
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (_, index) => Container(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: const Color(0xff97FFFF),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.data![index].title,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(snapshot.data![index].body),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool("isLoggedIn", false);
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return HttpLogin();
            },
          ));
        },
        child: const Icon(Icons.logout),
      ),
    );
  }
}
