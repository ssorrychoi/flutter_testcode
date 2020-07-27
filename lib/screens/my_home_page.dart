import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_code/model/counter.dart';
import 'package:test_code/screens/http_test_page.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
              'You have pushed the button this many times:',
            ),
            Consumer<Counter>(
              builder: (context, counter, child) {
                return Text(
                  counter.count.toString(),
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
            FlatButton(
              child: Text('HTTP test page'),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> HTTPTestPage())),
            )
          ],
        ),
      ),
      floatingActionButton: Column(
        children: <Widget>[
          FloatingActionButton(
            onPressed: () =>
                Provider.of<Counter>(context, listen: false).increment(),
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () =>
                Provider.of<Counter>(context, listen: false).decrement(),
            tooltip: 'Increment',
            child: Icon(Icons.content_cut),
          ),
        ],
      ),
    );
  }
}
