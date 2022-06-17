import 'package:api_prictice_flutter/example5/very_complex_data.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter API Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const VeryComplexData(),
    );
  }
}
