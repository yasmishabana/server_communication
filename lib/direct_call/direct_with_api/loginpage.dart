import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:server_communication/direct_call/direct_with_api/direct_list.dart';
import 'package:server_communication/direct_call/direct_with_api/registration.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HttpLogin extends StatefulWidget {
  @override
  State<HttpLogin> createState() => _HttpLoginState();
}

class _HttpLoginState extends State<HttpLogin> {
  final _formKey = GlobalKey<FormState>();

  // late bool newuser;
  bool? isLoggedIn;
  @override
  void initState() {
    super.initState();
    //_checkSession();
  }

  // void _checkSession() async {
  //   final prefs = await SharedPreferences.getInstance();

  //   setState(() {
  //     isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  //   });
  //   if (isLoggedIn == true) {
  //     Navigator.push(context, MaterialPageRoute(
  //       builder: (context) {
  //         return DirectListExample();
  //       },
  //     ));
  //   }
  //   log("isloggedin = " + isLoggedIn.toString());
  // }

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late String username, password;
  login(username, password) async {
    Map data = {'username': username, 'password': password};
    final response = await http.post(
      Uri.parse("http://192.168.245.32:8080/TestProject/http_login.jsp"),
      body: data,
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      log(response.body.toString());
      Map<String, dynamic> resposne = jsonDecode(response.body);
      if ("success" == resposne['message']) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Login Successully completed !.'),
          backgroundColor: Color.fromARGB(255, 175, 5, 152),
        ));
        final prefs = await SharedPreferences.getInstance();
        //key : value
        prefs.setBool("isLoggedIn", true);
        prefs.setString("username", username);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DirectListExample()));
            //ListDataExample()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Login failed.'),
          backgroundColor: Color.fromARGB(255, 3, 31, 53),
        ));
      }
    } else {
      print("Please try again!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 168, 5, 133),
          title: Text('Login Page'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height / 2.4,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 1,
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'User Name',
                          hintText: 'Enter Your Name',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          username = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          hintText: 'Enter Password',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          password = value;
                        },
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          color: Color.fromARGB(255, 175, 5, 152)),
                      child: TextButton(
                        child: const Text(
                          'Sign In',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            login(usernameController.text,
                                passwordController.text);
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          color: Color.fromARGB(255, 175, 5, 152)),
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: TextButton(
                        child: const Text('Sign UP',
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterScreen()));
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
