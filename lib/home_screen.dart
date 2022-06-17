import 'dart:convert';

import 'package:api_prictice_flutter/models/posts_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart ' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostsModel> postsList = [];

  Future<List<PostsModel>> getAllPosts() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        postsList.add(PostsModel.fromJson(i));
      }
      return postsList;
    } else {
      return postsList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('REST API'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getAllPosts(),
              builder: ((context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                    itemCount: postsList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(
                            postsList[index].title.toString(),
                          ),
                          subtitle: Text(
                            postsList[index].body.toString(),
                          ),
                        ),
                      );
                    },
                  );
                }
              }),
            ),
          ),
        ],
      ),
    );
  }
}
