import 'package:flutter/material.dart';
import 'package:keep_note_app/view.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Note App"),
      ),
      floatingActionButton: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return view();
              },
            ));
          },
          icon: Icon(Icons.add)),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(10),
          color: Colors.pink,
          child: Container(
            margin: EdgeInsets.all(10),
            color: Colors.lightGreenAccent,
            child: IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return view();
                    },
                  ));
                },
                icon: Icon(Icons.add)),
          ),
        ),
      ),
    );
  }
}
