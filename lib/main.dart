import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xfer/xfer.dart';

Map<String, String> get kinveyPostHeaders => {
      'Content-Type': 'application/json',
      'Authorization': 'Basic c3RldmVuLnNtaXRoOkZIQ1AyMDIwIQ==',
    };
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String caption = 'Waiting...';
  Xfer? xfer;

  @override
  void initState() {
    super.initState();
    xfer = Xfer(httpPostFunction: http.post);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Generic header',
            ),
            Text(
              '$caption',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final String url = 'https://jsonplaceholder.typicode.com/todos';
          //final String url = 'https://baas.kinvey.com/rpc/kid_rk7CWpu8w/custom/getSurvey?surveyKey=1';
          final dartz.Either<XferFailure, XferResponse> result = await xfer!.post(url, headers: kinveyPostHeaders);
          setState(() {
            result.fold(
              (failure) => caption = '${failure.toString()}',
              (response) => caption = '${response.toString()}',
            );
          });
          debugPrint('$result');
        },
        tooltip: 'Post',
        child: Icon(Icons.add),
      ),
    );
  }
}
