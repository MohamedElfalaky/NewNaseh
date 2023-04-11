import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  List<Map<String, dynamic>> items = [
    {'name': 'Item 1', 'isSelected': false},
    {'name': 'Item 2', 'isSelected': false},
    {'name': 'Item 3', 'isSelected': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                items[index]['isSelected'] = !items[index]['isSelected'];
              });
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                color: items[index]['isSelected'] ? Colors.blue : Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              child: ListTile(
                title: Text(items[index]['name']),
              ),
            ),
          );
        },
      ),
    );
  }
}
