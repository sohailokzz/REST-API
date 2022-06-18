import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RestApiImageUpload extends StatefulWidget {
  const RestApiImageUpload({Key? key}) : super(key: key);

  @override
  State<RestApiImageUpload> createState() => _RestApiImageUploadState();
}

class _RestApiImageUploadState extends State<RestApiImageUpload> {
  File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;

  Future getImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {});
    } else {
      print('Image not upload');
    }
  }

  Future<void> uploadImage() async {
    setState(() {
      showSpinner = true;
    });
    var stream = http.ByteStream(image!.openRead());
    stream.cast();

    var length = await image!.length();
    var uri = Uri.parse('https://fakestoreapi.com/products');
    var request = http.MultipartRequest('POST', uri);
    request.fields['title'] = "Static title";

    var multiport = http.MultipartFile(
      'image',
      stream,
      length,
    );

    request.files.add(multiport);

    var response = await request.send();

    if (response.statusCode == 200) {
      setState(() {
        showSpinner = false;
      });
      print('Image Uploaded');
    } else {
      setState(() {
        showSpinner = false;
      });
      print('Image Not uploaded');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Upload Image'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                getImage();
              },
              child: Container(
                  child: image == null
                      ? const Center(
                          child: Text('Pick Image'),
                        )
                      : Container(
                          child: Center(
                            child: Image.file(
                              File(image!.path).absolute,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )),
            ),
            const SizedBox(
              height: 150,
            ),
            GestureDetector(
              onTap: () {
                uploadImage();
              },
              child: Container(
                height: 50,
                width: 200,
                color: Colors.green,
                child: const Center(child: Text('Upload')),
              ),
            )
          ],
        ),
      ),
    );
  }
}
