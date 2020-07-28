import 'package:flutter/material.dart';

class TestForHTTP extends StatefulWidget {
  @override
  _TestForHTTPState createState() => _TestForHTTPState();
}

class _TestForHTTPState extends State<TestForHTTP> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('http Test'),
      ),
      body: Text('Hello'),
    );
  }
}
