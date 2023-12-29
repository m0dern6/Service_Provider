import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Signup extends StatelessWidget {
  Signup({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email = '';
  String username = '';
  String password = '';
  String confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              left: -100,
              child: Container(
                width: 450,
                height: 450,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(
                    255,
                    237,
                    126,
                    163,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 150,
              left: 100,
              child: Container(
                width: 450,
                height: 450,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 237, 126, 163),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Create\nAccount :)',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Align(
                    alignment: Alignment.center,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            onSaved: (value) => email = value!,
                            decoration: InputDecoration(
                              hintText: 'Email ID',
                              hintStyle: TextStyle(fontSize: 20),
                              border: InputBorder.none,
                            ),
                          ),
                          const Divider(
                            color: Colors.black,
                          ),
                          TextFormField(
                            onSaved: (value) => username = value!,
                            decoration: InputDecoration(
                              hintText: 'Username',
                              hintStyle: TextStyle(fontSize: 20),
                              border: InputBorder.none,
                            ),
                          ),
                          const Divider(
                            color: Colors.black,
                          ),
                          TextFormField(
                            onSaved: (value) => password = value!,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: TextStyle(fontSize: 20),
                              border: InputBorder.none,
                            ),
                          ),
                          const Divider(
                            color: Colors.black,
                          ),
                          TextFormField(
                            onSaved: (value) => confirmPassword = value!,
                            decoration: InputDecoration(
                              hintText: 'Confirm Password',
                              hintStyle: TextStyle(fontSize: 20),
                              border: InputBorder.none,
                            ),
                          ),
                          const Divider(
                            color: Colors.black,
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                sendUserData(context, email, username, password,
                                    confirmPassword);
                              }
                            },
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.only(left: 20, right: 20),
                                    child: Text(
                                      'Sign Up',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 30),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Already have an account? '),
                                    GestureDetector(
                                      onTap: () => {
                                        Navigator.pushReplacementNamed(
                                            context, 'login')
                                      },
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> sendUserData(BuildContext context, String email, String username,
      String password, String confirmPassword) async {
    final response = await http.post(
      Uri.parse('https://658d2f487c48dce94738a5a8.mockapi.io/api/v1/testing'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'email': email,
        'name': username,
        'password': password,
        'phone': confirmPassword,
      }),
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data successfully sent to the API')),
      );
      _formKey.currentState!.reset();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send data to the API')),
      );
    }
  }
}
