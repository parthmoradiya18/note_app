import 'package:flutter/material.dart';
import 'package:keep_note_app/edit.dart';
import 'package:keep_note_app/view.dart';


class notesapp extends StatefulWidget {
  @override
  State<notesapp> createState() => _notesappState();
}

class _notesappState extends State<notesapp> {
  List<Map> l = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String sql = "select * from book";
    view.database!.rawQuery(sql).then((value) {
      l = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes App view"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return view();
                  },
                ));
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: GridView.builder(
        itemCount: l.length,
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(5),
            color: Colors.grey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(5),
                    color: Colors.orangeAccent,
                    child: Text(
                      "${l[index]['titles']}",
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    color: Colors.orangeAccent,
                    child: Text(
                      "${l[index]['notes']}",
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            String sql =
                                "DELETE FROM book WHERE id =${l[index]['id']}";
                            view.database!.rawDelete(sql).then((value) {
                              print(value);
                            });

                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return notesapp();
                              },
                            ));
                          },
                          icon: Icon(Icons.delete)),
                      IconButton(
                          onPressed: () {
                            String sql =
                                "UPDATE FROM book WHERE id =${l[index]['id']}";
                            view.database!.rawUpdate(sql).then((value) {
                              print(value);
                            });
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return edit(l[index]);
                              },
                            ));
                          },
                          icon: Icon(Icons.edit)),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
