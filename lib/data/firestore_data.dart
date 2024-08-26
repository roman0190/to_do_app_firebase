import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app_firebase/model/notes_model.dart';
import 'package:uuid/uuid.dart';

class FirestoreData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> createUser(String email) async {
    try {
      await _firestore.collection('users').doc(_auth.currentUser!.uid).set({
        'id': _auth.currentUser!.uid,
        'email': email
      });
      return true;
    } catch (e) {
      return true;
    }
  }

  Future<bool> addNote(String title, String subtitle, int image) async {
    try {
      var uuid = const Uuid().v4();
      DateTime time = DateTime.now();

      await _firestore.collection('users').doc(_auth.currentUser!.uid).collection('notes').doc(uuid).set({
        'id': uuid,
        'title': title,
        'subtitle': subtitle,
        'isDone': false,
        'image': image,
        'time': '${time.hour}:${time.minute}',
      });
      return true;
    } catch (e) {
      return true;
    }
  }

  List getNotes(AsyncSnapshot snapshot) {
    try {
      final notesList = snapshot.data!.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Note(
          data['id'],
          data['title'],
          data['subtitle'],
          data['time'],
          data['image'],
          data['isDone'],
        );
      }).toList();

      return notesList;
    } catch (e) {
      return [];
    }
  }

  Stream<QuerySnapshot> stream(bool isDone) {
    return _firestore.collection('users').doc(_auth.currentUser!.uid).collection('notes').where('isDone', isEqualTo: isDone).snapshots();
  }

  Future<bool> isDone(String uuid, bool isDone) async {
    try {
      await _firestore.collection('users').doc(_auth.currentUser!.uid).collection('notes').doc(uuid).update({
        'isDone': isDone
      });
      return true;
    } catch (e) {
      print(e);
      return true;
    }
  }

  Future<bool> upadateNote(String uuid, int image, String title, String subtitle) async {
    try {
      DateTime time = DateTime.now();
      await _firestore.collection('users').doc(_auth.currentUser!.uid).collection('notes').doc(uuid).update({
        'title': title,
        'subtitle': subtitle,
        'image': image,
        'time': '${time.hour}:${time.minute}',
      });
      return true;
    } catch (e) {
      print(e);
      return true;
    }
  }

  Future<bool> deleteNote(String uuid) async {
    try {
      await _firestore.collection('users').doc(_auth.currentUser!.uid).collection('notes').doc(uuid).delete();
      return true;
    } catch (e) {
      print(e);
      return true;
    }
  }
}
