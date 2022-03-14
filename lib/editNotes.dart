import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes/delete_icons.dart';
import 'package:notes/save_icons.dart';

class editNotes extends StatefulWidget {

  DocumentSnapshot docToEdit;
  editNotes({required this.docToEdit});

  @override
  _editNotesState createState() => _editNotesState();
}

class _editNotesState extends State<editNotes> {

  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  @override
  void initState() {
    title = TextEditingController(text: (widget.docToEdit.data() as Map)['title']);
    content = TextEditingController(text: (widget.docToEdit.data() as Map)['content']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.blue,
          ),
          actions: [
            TextButton(onPressed: () {
              widget.docToEdit.reference.delete().whenComplete(() => Navigator.pop(context));
            },
              child: Icon(Delete.delete),
            ),
            TextButton(onPressed: () {
              widget.docToEdit.reference.update({
              'title': title.text,
              'content': content.text,
               }).whenComplete(() => Navigator.pop(context));
              },
              child: Icon(Save.floppy),
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(7, 10, 7, 0),
              padding: EdgeInsets.fromLTRB(0, 25, 5, 0),
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                  border: Border.all(color: Colors.black12),
                  color: Colors.white
              ),
              child: TextField(
                controller: title,
                decoration: InputDecoration(
                  hintText: "Title",
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    //borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),

            Expanded(
              child: Container(
                margin: EdgeInsets.fromLTRB(7, 7, 7, 7),
                padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                //height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    border: Border.all(color: Colors.black12),
                    color: Colors.white),
                child: TextField(
                  controller: content,
                  style: TextStyle(
                    //fontSize: 40.0,
                    height: 1.6,
                  ),
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    //hintText: "Content",
                    border: UnderlineInputBorder(
                      borderSide: BorderSide.none,
                      //borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }
}
