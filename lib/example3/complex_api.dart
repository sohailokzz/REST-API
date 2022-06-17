import 'dart:convert';

import 'package:api_prictice_flutter/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ComplexJsonData extends StatefulWidget {
  const ComplexJsonData({Key? key}) : super(key: key);

  @override
  State<ComplexJsonData> createState() => _ComplexJsonDataState();
}

class _ComplexJsonDataState extends State<ComplexJsonData> {
  List<UserModel> userList = [];

  Future<List<UserModel>> getUser() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
    );
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (var i in data) {
        userList.add(
          UserModel.fromJson(i),
        );
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complex Json Data'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUser(),
              builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                return ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              snapshot.data![index].name.toString(),
                            ),
                            Text(
                              snapshot.data![index].username.toString(),
                            ),
                            Text(
                              snapshot.data![index].email.toString(),
                            ),
                            Text(
                              snapshot.data![index].address!.street.toString() +
                                  snapshot.data![index].address!.city
                                      .toString(),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
