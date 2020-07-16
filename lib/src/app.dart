import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'package:pics_demo/src/widgets/image_list.dart';
import 'models/image_model.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int imageCounter = 0;
  List<ImageModel> images = [];

  void fetchImage() async {
    imageCounter++;
    var response =
        await get('https://jsonplaceholder.typicode.com/photos/$imageCounter');

    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String prettyprint = encoder.convert(json.decode(response.body));
    print(prettyprint);

    if (response.statusCode == 200) {
      var imageModel = ImageModel.fromJson(json.decode(response.body));

      setState(() {
        images.add(imageModel);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text('Test App'),
          ),
          body: ImageList(images),
          floatingActionButton: FloatingActionButton(
            onPressed: fetchImage,
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            backgroundColor: Colors.blue,
          ),
        ),
      ),
    );
  }
}
