import 'package:flutter/material.dart';

class ListTestPage extends StatelessWidget {
  List<String> items = List<String>.generate(1000, (index) => "Item $index");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('List Test'),
        ),
        body: ListView.builder(
            key: Key('long_list'),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('${items[index]}', key: Key('item_${index}_text')),
              );
            }));
  }
}
