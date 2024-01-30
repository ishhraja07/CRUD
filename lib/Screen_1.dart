import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Screen1 extends StatefulWidget {
  const Screen1({Key? key}) : super(key: key);

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  TextEditingController _t1 = TextEditingController();
  TextEditingController _t2 = TextEditingController();
  TextEditingController _t3 = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Delay the post request until the widgets are initialized
    // Future.delayed(Duration.zero, () {
    //   _sendPostRequest();
    // });
  }

  Future<void> _sendPostRequest(String departmentName,String departmentId,String departmentCode) async {
    final String apiUrl = 'http://192.168.205.223:8082/departments';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json', // Set the correct content type
        },
        body: jsonEncode({
          "departmentName": "$departmentName",
          "departmentAddress": "$departmentId",
          "departmentCode": "$departmentCode",
        }),
      );

      if (response.statusCode == 200) {
        print('POST request successful');
        print('Response: ${response.body}');
      } else {
        print('Error: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AppBar(
                title: Text(
                  "Crud Operations",
                  style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),
                ),
                backgroundColor: Colors.blueAccent,
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: _t1,
                decoration: InputDecoration(
                  labelText: 'Department Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Department Name cannot be empty';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: _t2,
                decoration: InputDecoration(
                  labelText: 'Department Id',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Department Id cannot be empty';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: _t3,
                decoration: InputDecoration(
                  labelText: 'Department Code',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Department Code cannot be empty';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Form is valid, perform actions with the user input
                    String departmentName = _t1.text;
                    String departmentId = _t2.text;
                    String departmentCode = _t3.text;
                    _sendPostRequest(departmentName, departmentId, departmentCode);
                  }
                },
                child: Text('Add', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Screen1(),
  ));
}
