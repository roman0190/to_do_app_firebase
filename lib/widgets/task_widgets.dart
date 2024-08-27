import 'package:flutter/material.dart';
import 'package:to_do_app_firebase/data/firestore_data.dart';
import 'package:to_do_app_firebase/model/notes_model.dart';
import 'package:to_do_app_firebase/screens/edit_note_page.dart';

class TaskWidgets extends StatefulWidget {
  Note _note;
  TaskWidgets(this._note, {super.key});

  @override
  State<TaskWidgets> createState() => _TaskWidgetsState();
}

class _TaskWidgetsState extends State<TaskWidgets> {
  @override
  Widget build(BuildContext context) {
    bool isDone = widget._note.isDone;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Container(
        width: double.infinity,
        height: 130,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            children: [
              image(),
              const SizedBox(width: 20),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      SizedBox(
                        height: 30,
                        width: 240,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 30,
                              width: 190,
                              child: Text(
                                widget._note.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              height: 57,
                              child: Checkbox(
                                  value: isDone,
                                  onChanged: (value) {
                                    setState(() {
                                      isDone = !isDone;
                                    });
                                    FirestoreData().isDone(widget._note.id, isDone);
                                  }),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        height: 20,
                        width: 220,
                        child: Text(
                          widget._note.subtitle,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.shade400,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Spacer(),
                      editTime()
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget editTime() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            width: 90,
            height: 28,
            decoration: BoxDecoration(
              color: Colors.greenAccent,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5, top: 4, left: 10),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/icon_time.png',
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget._note.time,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditNotePage(widget._note),
                ),
              );
            },
            child: Container(
              width: 90,
              height: 28,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 215, 238, 238),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 4, top: 4, left: 10),
                child: Row(
                  children: [
                    Image.asset('assets/images/icon_edit.png'),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "Edit",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container image() {
    return Container(
      height: 130,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage('assets/images/${widget._note.image}.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
