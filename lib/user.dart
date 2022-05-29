import 'dart:convert';

import 'package:admitkard/const/endpoints.dart';
import 'package:admitkard/service/network_utilities.dart';
import 'package:flutter/material.dart';

class User extends StatefulWidget {
  const User({Key? key}) : super(key: key);

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  TextEditingController email = TextEditingController();
  String emailWr = "Enter Email to get data";
  var userDetails = null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextField(
            controller: email,
            decoration: const InputDecoration(
              hintText: 'Enter Email Id here',
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              var response = await UserNetworkUtilities().viewUser(
                "$LIST_USER/${email.text}",
              );
              setState(() {
                emailWr = response.body == null
                    ? "Enter correct Email to get data"
                    : "Enter Email to get data";
                userDetails = jsonDecode(response.body);
              });
            },
            child: const Text("Find User"),
          ),
          userDetails == null
              ? Text("Enter Email to get data")
              : FutureBuilder(
                  builder: ((context, snapshot) =>
                      // Text("Name: " + userDetails['name'])),
                      Card(
                        child: Column(
                          children: [
                            Text("Name: " + userDetails['name']),
                            Text("Email: " + userDetails['_id']),
                            Text("Number: " + userDetails['number']),
                            Text("Course: " + userDetails['course']),
                            Text("Selected Country: " +
                                userDetails['selected_pref']),
                          ],
                        ),
                      )),
                ),
        ],
      ),
    );
  }
}
