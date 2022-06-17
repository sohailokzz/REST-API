import 'dart:convert';

import 'package:api_prictice_flutter/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VeryComplexData extends StatefulWidget {
  const VeryComplexData({Key? key}) : super(key: key);

  @override
  State<VeryComplexData> createState() => _VeryComplexDataState();
}

class _VeryComplexDataState extends State<VeryComplexData> {
  Future<ProductsModel> getData() async {
    final response = await http.get(
      Uri.parse('https://webhook.site/0b063519-dd9e-4fa2-956e-64c3d0ff6b6f'),
    );
    var data = jsonDecode(
      response.body.toString(),
    );
    if (response.statusCode == 200) {
      return ProductsModel.fromJson(data);
    } else {
      return ProductsModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Api Course'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<ProductsModel>(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.data!.length,
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: Text(snapshot.data!.data![index].name
                                    .toString()),
                                subtitle: Text(snapshot
                                    .data!.data![index].shopemail
                                    .toString()),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(snapshot
                                      .data!.data![index].image
                                      .toString()),
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * .3,
                                width: MediaQuery.of(context).size.width * 1,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot
                                        .data!.data![index].image!.length,
                                    itemBuilder: (context, position) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .25,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .5,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(snapshot
                                                      .data!
                                                      .data![index]
                                                      .image![position]
                                                      .toString()))),
                                        ),
                                      );
                                    }),
                              ),
                              Icon(snapshot.data!.data![index] == false
                                  ? Icons.favorite
                                  : Icons.favorite_outline)
                            ],
                          );
                        });
                  } else {
                    return const Text('Loading');
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
