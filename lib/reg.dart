import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
//name,place,email,phone,gender,username,password
  String radioitemvalue = "male";
  TextEditingController usernamcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  int id = 1;
  String? name, phone, place, email;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Registration",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Name"),
                    hintText: 'enter your name',
                  ),
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please enter name ";
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Place"),
                    hintText: 'enter your place',
                  ),
                  onChanged: (value) {
                    setState(() {
                      place = value;
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please enter name ";
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Email"),
                    hintText: 'enter your email',
                  ),
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please enter email ";
                    } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Phone"),
                    hintText: 'enter your phone',
                  ),
                  onChanged: (value) {
                    setState(() {
                      phone = value;
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please enter phone ";
                    } else if (value.length > 10 || value.length < 10) {
                      return "Please enter valid phone number ";
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Gender"),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Radio(
                      value: 1,
                      groupValue: id,
                      onChanged: (value) {
                        setState(() {
                          radioitemvalue = 'male';
                          id = value!;
                        });
                      },
                    ),
                    Text("Male"),
                    SizedBox(
                      width: 10,
                    ),
                    Radio(
                      value: 2,
                      groupValue: id,
                      onChanged: (value) {
                        setState(() {
                          radioitemvalue = 'female';
                          id = value!;
                        });
                      },
                    ),
                    Text("Female"),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                TextFormField(
                  controller: usernamcontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Username"),
                    hintText: 'enter your username',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please enter username ";
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: passwordcontroller,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Password"),
                    hintText: 'enter your password',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please enter password ";
                    }
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            log("name log==" + name.toString());
                            log("phone ==" + phone.toString());
                            log("place ==" + place.toString());
                            log("email ==" + email.toString());
                            log("gender ==" + radioitemvalue.toString());
                            log("username == " + usernamcontroller.text);
                            log("password ==" + passwordcontroller.text);
                          }
                        },
                        child: Text("Registration")),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
