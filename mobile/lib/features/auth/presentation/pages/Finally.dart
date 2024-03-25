import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Finally extends StatefulWidget {
  const Finally({super.key});

  @override
  State<Finally> createState() => _FinallyState();
}

class _FinallyState extends State<Finally> {
  File? _selected;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                child: Text("pick image"),
                onPressed: () {
                  _ImagePicker();
                },
              ),
              ElevatedButton(
                onPressed: () {
                  submit();
                },
                child: Text("submit"),
              ),
              Expanded(
                child: _selected != null
                    ? Image.file(File(_selected!.path))
                    : Text("Nothing"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _ImagePicker() async {
    final resultImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _selected = File(resultImage!.path);
    });
  }

  Future<void> submit() async {
    String url = "http://127.0.0.1:8000/instagram/post/";
    final Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization':
          "JWT eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzE2NDg0NDQ2LCJpYXQiOjE3MTEzMDA0NDYsImp0aSI6Ijg1NjIzOTc1Yjk3MTRjM2Y5Y2VlNDBmMjU3NDdhZjdhIiwidXNlcl9pZCI6M30.bx62k9lJdBoQHotY39gYsSREry-G7kQTaJClQJvSLn4",
    };
    final request = http.MultipartRequest('POST', Uri.parse(url));

    request.headers.addAll(headers);
    // request.fields['text'] = "yohanse";
    request.fields['text'] = "yohanse";
    request.files.add(await http.MultipartFile.fromPath(
      'images',
      _selected!.path,
      filename: 'image'
    ));
    request.files.add(await http.MultipartFile.fromPath(
      'images',
      _selected!.path,
      filename: "image",
    ));
    print(request.files);
    final response = await request.send();
    print("yohanse mehabaw");
    print(response);
    // final responseData = await http.post(Uri.parse(url),
    //     headers: {'Content-Type': 'application/json'},
    //     body: jsonEncode({
    //       'text': "yohanse",
    //       'images': [_selected]
    //     }));
    // final response = jsonDecode(responseData.body);
    // print(response);
    // if (responseData.statusCode == 200 || responseData.statusCode == 201) {
    //   return response['valid'];
    // }
    // return true;
  }
}
