import 'dart:convert';

import 'package:admitkard/service/network_utilities.dart';
import 'package:admitkard/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'const/endpoints.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AdmitKard',
      theme: ThemeData.dark(),
      home: const MyHomePage(title: 'AdmitKard'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<bool> country = [false, false, false, false, false, false, false];
  List<bool> countryAdded = [];
  List<String> countryName = [
    "USA",
    "Australia",
    "New-Zealand",
    "Canada",
    "UK",
    "Ireland",
    "Germany"
  ];
  String dropdownValue = 'Select Course';
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController number = TextEditingController();

  String ending = "";
  String selected_values = "";
  bool selectedpref = true;

  void initState() {
    super.initState();
  }

  Response? response;
  Future addUser() async {
    if (name.text == "" || name.text.length < 4) {
      setState(() {
        ending = "Please enter full name";
      });
    } else if (email.text == "" ||
        email.text.length < 5 ||
        !email.text.contains("@")) {
      setState(() {
        ending = "Please enter email";
      });
    } else if (number.text == "" || number.text.length < 10) {
      setState(() {
        ending = "Please enter number";
      });
    } else if (dropdownValue == "Select Course") {
      setState(() {
        ending = "Please choose a course";
      });
    } else if (selected_values == "") {
      setState(() {
        ending = "Please choose atleast one country";
      });
    } else {
      var body = jsonEncode(<String, String>{
        "name": name.text.toString(),
        "email": email.text.toString(),
        "number": number.text.toString(),
        "course": dropdownValue,
        "selected_pref": selected_values
      });
      response = await UserNetworkUtilities().addUser(ADD_USER, body);
      // print(response!.body);
      setState(() {
        if (response!.body.contains(email.text.toString())) {
          ending = "User ${name.text} Created";
          name.text = "";
          email.text = "";
          number.text = "";
          List<bool> country = [
            false,
            false,
            false,
            false,
            false,
            false,
            false
          ];
          selected_values = "";
          dropdownValue = "Select Course";
        } else if (response!.body.contains("Done")) {
          ending = "User ${name.text} Updated";
          name.text = "";
          email.text = "";
          number.text = "";
          List<bool> country = [
            false,
            false,
            false,
            false,
            false,
            false,
            false
          ];
          selected_values = "";
          dropdownValue = "Select Course";
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const User()),
                );
              },
              icon: const Icon(Icons.person_outline))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text("Enter Details"),
          TextField(
            controller: name,
            decoration: const InputDecoration(
              labelText: 'Name',
            ),
          ),
          TextField(
            controller: email,
            decoration: const InputDecoration(
              labelText: 'Email',
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          TextField(
            controller: number,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Contact Number',
            ),
          ),
          DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_circle_down_outlined),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
            items: <String>['Select Course', 'UG', 'PG']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          selectedpref
              ? ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedpref = !selectedpref;
                    });
                  },
                  child: const Text("Select Pref"))
              : Card(
                  child: Column(
                    children: [
                      CheckboxListTile(
                        title: const Text("USA"),
                        value: country[0],
                        onChanged: (value) {
                          setState(() {
                            country[0] = value!;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text("Australia"),
                        value: country[1],
                        onChanged: (value) {
                          setState(() {
                            country[1] = value!;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text("New-Zealand"),
                        value: country[2],
                        onChanged: (value) {
                          setState(() {
                            country[2] = value!;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text("Canada"),
                        value: country[3],
                        onChanged: (value) {
                          setState(() {
                            country[3] = value!;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text("UK"),
                        value: country[4],
                        onChanged: (value) {
                          setState(() {
                            country[4] = value!;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text("Ireland"),
                        value: country[5],
                        onChanged: (value) {
                          setState(() {
                            country[5] = value!;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text("Germany"),
                        value: country[6],
                        onChanged: (value) {
                          setState(() {
                            country[6] = value!;
                          });
                        },
                      ),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedpref = !selectedpref;
                              for (var i = 0; i < country.length; i++) {
                                if (country[i]) {
                                  selected_values =
                                      selected_values + countryName[i] + " ,";
                                }
                              }
                            });
                          },
                          child: Text('OK')),
                    ],
                  ),
                ),
          selected_values != ""
              ? Text("Selected Values = $selected_values")
              : const Text(""),
          ElevatedButton(
              onPressed: addUser, child: const Text("Submit Details")),
          // FutureBuilder(
          //     builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          //   return snapshot.hasData
          //       ? const Text("User created succesfully")
          //       : const Text("Hit submit to add user");
          // })
          Text(ending),
        ],
      ),
    );
  }
}
