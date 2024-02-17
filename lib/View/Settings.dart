import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Homepage.dart';

class Settings extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black87,
            )),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Settings",
          style: TextStyle(fontSize: 25, color: Colors.black87),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 20, top: 20),
            child: TextField(
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white24,
                hintText: " Enter your City & Country",
                hintStyle: TextStyle(color: Colors.black87),
                labelText: "Location",
                labelStyle: TextStyle(color: Colors.black87),
                suffixIcon: Icon(Icons.location_on),
                suffixIconColor: Colors.black87,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide:
                      BorderSide(color: Colors.white), // Change this line
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {},
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
