import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_code/model/counter.dart';
import 'package:test_code/screens/http_test_page.dart';
import 'package:test_code/screens/list_test_page.dart';

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
                  key: Key('counter'),
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
            RaisedButton(
              child: Text('http Test Page'),
              key: Key('httpPage'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TestForHTTP()));
              },
            ),
            RaisedButton(
              child: Text('list Test Page'),
              key: Key('listPage'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ListTestPage()));
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () =>
                Provider.of<Counter>(context, listen: false).increment(),
            tooltip: 'Increment',
            key: Key('Increment'),
            heroTag: null,
            child: Icon(Icons.add),
          ),
          Padding(padding: EdgeInsets.all(8)),
          FloatingActionButton(
            onPressed: () =>
                Provider.of<Counter>(context, listen: false).decrement(),
            tooltip: 'Decrement',
            key: Key('Decrement'),
            heroTag: null,
            child: Icon(Icons.content_cut),
          ),
        ],
      ),
    );
  }
}
