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
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('API Fetch Example'),
          backgroundColor: Colors.blue,
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
                  return Column(
                    children: [
                      SizedBox(height: 30,),
                      Container(


                        color: Colors.redAccent,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text("DepartmentId : ${todos?[index]['departmentId']}",style: TextStyle(fontSize: 15),),
                              ],
                            ),
                            Row(
                              children: [
                                Text("DepartmentName : ${todos?[index]['departmentName']}",style: TextStyle(fontSize: 15),),
                              ],
                            ),

                            Row(
                              children: [
                                Text("DepartmentAddress : ${todos?[index]['departmentAddress']}",style: TextStyle(fontSize: 15),),
                              ],
                            ),
                            Row(
                              children: [
                                Text("DepartmentCode : ${todos?[index]['departmentCode']}",style: TextStyle(fontSize: 15),),
                              ],
                            ),
                            SizedBox(height: 10,),
                          ],
                        ),
                      )
                    ],
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