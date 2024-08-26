import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app_firebase/data/firestore_data.dart';
import 'package:to_do_app_firebase/widgets/task_widgets.dart';

class StreamNote extends StatelessWidget {
  bool done;
  StreamNote(this.done, {super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirestoreData().stream(done),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        final noteList = FirestoreData().getNotes(snapshot);
        return ListView.builder(
          shrinkWrap: true,
          itemCount: noteList.length,
          itemBuilder: (context, index) {
            final note = noteList[index];
            return Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                FirestoreData().deleteNote(note.id);
              },
              child: TaskWidgets(note),
            );
          },
        );
      },
    );
  }
}
