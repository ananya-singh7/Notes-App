import 'package:firebase_core/firebase_core.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes/notes_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(notes());
}

class notes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: notes_screen(),
    );
  }
}