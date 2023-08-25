import 'package:flutter/material.dart';
import 'package:keep_note_app/notesapp.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class view extends StatefulWidget {
  static Database? database;

  @override
  State<view> createState() => _viewState();
}

class _viewState extends State<view> {
  TextEditingController title = TextEditingController();
  TextEditingController note = TextEditingController();

  get_sql() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'not.db');

    view.database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
              'CREATE TABLE book (id INTEGER PRIMARY KEY ,titles TEXT,notes TEXT)');
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_sql();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Note Typing"),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(5),
            color: Colors.lightGreenAccent,
            child: TextField(
              decoration:
              InputDecoration(hintText: "Title", labelText: "Title"),
              controller: title,
            ),
          ),
          Card(
            margin: EdgeInsets.all(5),
            color: Colors.lightGreenAccent,
            child: TextField(
              decoration: InputDecoration(hintText: "Note", labelText: "Note"),
              controller: note,
            ),
          ),
          ElevatedButton(
              onPressed: () {
                String titles = title.text;
                String notes = note.text;

                String sql = "insert into book values(null,'$titles','$notes')";
                view.database!.rawInsert(sql).then((value) {
                  print(value);
                });
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return notesapp();
                  },
                ));
              },
              child: Text("submit")),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return notesapp();
                  },
                ));
              },
              child: Text("view")),
        ],
      ),
    );
  }
}
