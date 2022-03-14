import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes/addNotes.dart';
import 'package:notes/editNotes.dart';

import 'custom_icons_icons.dart';

class notes_screen extends StatelessWidget {

  final ref = FirebaseFirestore.instance.collection("notes1");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      //backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
        child: Text("Get Started",
        style: TextStyle(
        fontFamily: 'Playfair Display',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.blue),
    ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(CustomIcons.pen),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => addNotes(),
              ),
          );
        },
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(0, 7, 0, 5),
        child: StreamBuilder(
          stream: ref.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return ListView.builder(
                itemCount: snapshot.hasData?(snapshot.data?.docs.length):0,
                itemBuilder: (_,index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                      builder: (_) => editNotes(docToEdit: snapshot.data!.docs.elementAt(index),),
                  ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(7, 7, 7, 0),
                    padding: EdgeInsets.fromLTRB(7, 7, 7, 7),
                  height: 120,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                      color: Colors.white),
                  child: Row(
                    children: [
                      Container(
                        //color: Colors.black26,
                        height: 100,
                        width: 310,
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                        padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text((snapshot.data!.docs.elementAt(index).data() as Map)['title'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(
                                  fontFamily: 'Playfair Display',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  //color: Colors.blue,
                              ),
                            ),
                            SizedBox(height: 15),
                            Text((snapshot.data!.docs.elementAt(index).data() as Map)['content'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(
                                fontFamily: 'Playfair Display',
                                fontSize: 16,
                                //fontWeight: FontWeight.bold,
                                //color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ),
              );
            });
          }
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 15,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(""),
        ),
        //notchMargin: 5,
    ),

    );
  }
}