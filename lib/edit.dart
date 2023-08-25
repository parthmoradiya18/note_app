import 'package:flutter/material.dart';
import 'package:keep_note_app/notesapp.dart';
import 'package:keep_note_app/view.dart';

class edit extends StatefulWidget {
  Map l;

  edit(this.l);

  @override
  State<edit> createState() => _editState();
}

class _editState extends State<edit> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    t1.text = widget.l['titles'];
    t2.text = widget.l['notes'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UPdate"),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(5),
            color: Colors.lightGreenAccent,
            child: TextField(
              decoration:
              InputDecoration(hintText: "Title", labelText: "Title"),
              controller: t1,
            ),
          ),
          Card(
            margin: EdgeInsets.all(5),
            color: Colors.lightGreenAccent,
            child: TextField(
              decoration: InputDecoration(hintText: "Note", labelText: "Note"),
              controller: t2,
            ),
          ),
          ElevatedButton(
              onPressed: () {
                String titles = t1.text;
                String notes = t2.text;
                if (widget.l != null) {
                  String sql =
                      "update book set titles='$titles',notes='$notes' where id='${widget.l['id']}'";
                  view.database!.rawUpdate(sql);
                  setState(() {});
                }

                setState(() {});
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
              child: Text("view"))
        ],
      ),
    );
  }
}
