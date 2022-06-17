import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ComplexApiCustomModel extends StatefulWidget {
  const ComplexApiCustomModel({Key? key}) : super(key: key);

  @override
  State<ComplexApiCustomModel> createState() => _ComplexApiCustomModelState();
}

class _ComplexApiCustomModelState extends State<ComplexApiCustomModel> {
  var data;
  Future<void> getUser() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
    );
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complex Api Without Model'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Text('Loading...'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          children: [
                            Text(
                              data[index]['name'].toString(),
                            ),
                            Text(
                              data[index]['username'].toString(),
                            ),
                            Text(
                              data[index]['email'].toString(),
                            ),
                            Text(
                              data[index]['address']['street'].toString(),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
