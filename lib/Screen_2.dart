import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Screen_2 extends StatefulWidget {
  const Screen_2({super.key});

  @override
  State<Screen_2> createState() => _Screen_2State();
}

class _Screen_2State extends State<Screen_2> {
  final ApiService apiService = ApiService('http://192.168.205.223:8082/departments');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('API Fetch Example'),
        ),
        body: FutureBuilder(
          future: apiService.getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              // Display the list of todos using ListView.builder
              List? todos = snapshot.data;
              return ListView.builder(
                itemCount: todos?.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(todos?[index]['title']),
                    // You can customize the ListTile as needed
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
class ApiService {
  final String apiUrl;

  ApiService(this.apiUrl);

  Future<List<dynamic>> getData() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      return json.decode(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      print("Failed to load the data");
      throw Exception('Failed to load data');
    }
  }
}
