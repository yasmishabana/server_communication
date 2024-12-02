import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:http/http.dart' as http;
import 'package:server_communication/direct_call/model/albummode.dart';

Future<Album> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load album');
  }
}

class HttpExample extends StatefulWidget {
  const HttpExample({super.key});

  @override
  State<HttpExample> createState() => _MyAppState();
}

class _MyAppState extends State<HttpExample> {
  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetch Data Example'),
      ),
      body: Center(
        child: FutureBuilder<Album>(
          future: futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.title);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return const CircularProgressIndicator(
              color: Colors.purple,
            );
          },
        ),
      ),
    );
  }
}
