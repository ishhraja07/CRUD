import 'package:demo/Screen_2.dart';
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
  TextEditingController _t4 = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Delay the post request until the widgets are initialized
    // Future.delayed(Duration.zero, () {
    //   _sendPostRequest();
    // });
  }

  Future<void> _sendPostRequest(String departmentName,String departmentId,String departmentCode, String departmentAddress) async {
    final String apiUrl = 'http://192.168.205.223:8082/departments';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json', // Set the correct content type
        },
        body: jsonEncode({
          "departmentName":"$departmentName",
          "departmentAddress":"$departmentAddress",
          "departmentCode":"$departmentCode"
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
              // TextFormField(
              //   controller: _t2,
              //   decoration: InputDecoration(
              //     labelText: 'Department Id',
              //   ),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Department Id cannot be empty';
              //     }
              //     return null;
              //   },
              // ),
              // SizedBox(height: 10,),
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
              TextFormField(
                controller: _t4,
                decoration: InputDecoration(
                  labelText: 'Department Address',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Department Address cannot be empty';
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
                    String departmentAddress = _t4.text;
                    _sendPostRequest(departmentName, departmentId, departmentCode,departmentAddress);
                  }
                },
                child: Text('Add', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
              ),
              SizedBox(height: 10,),
              ElevatedButton(onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Screen_2()),
                );
              }, child: Text("View your get requests"))
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