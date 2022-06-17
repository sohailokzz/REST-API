import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AuthenticationApi extends StatefulWidget {
  const AuthenticationApi({Key? key}) : super(key: key);

  @override
  State<AuthenticationApi> createState() => _AuthenticationApiState();
}

class _AuthenticationApiState extends State<AuthenticationApi> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void logIn(String email, String password) async {
    try {
      Response response = await post(
        Uri.parse('https://reqres.in/api/login'),
        body: {
          'email': email,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data['token']);
        print('Login Successfully');
      } else {
        print('Failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authentication API'),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              hintText: 'Email',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: passwordController,
            decoration: const InputDecoration(
              hintText: 'Password',
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          ElevatedButton(
            onPressed: () {
              logIn(
                emailController.text,
                passwordController.text,
              );
            },
            child: const Text('Log In'),
          ),
        ],
      ),
    );
  }
}
