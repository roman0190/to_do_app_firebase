import 'package:flutter/material.dart';
import 'package:to_do_app_firebase/data/firestore_data.dart';
import 'package:to_do_app_firebase/model/notes_model.dart';

class EditNotePage extends StatefulWidget {
  final Note _note;
  const EditNotePage(this._note, {super.key});

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  late TextEditingController title;
  late TextEditingController subtitle;

  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();

 late int selectedIndex ;

  @override
  void initState() {
    super.initState();
    title = TextEditingController(text: widget._note.title);
    subtitle = TextEditingController(text: widget._note.subtitle);
    selectedIndex = widget._note.image; 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            textBox(title, _focusNode1, 1, "Enter a title"),
            const SizedBox(height: 20),
            textBox(subtitle, _focusNode2, 3, "Enter sub-title "),
            const SizedBox(height: 20),
            images(),
            const SizedBox(height: 20),
            button(),
          ],
        ),
      ),
    );
  }

  Widget button() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            FirestoreData().upadateNote(widget._note.id,selectedIndex , title.text, subtitle.text);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.greenAccent,
            minimumSize: const Size(170, 48),
          ),
          child:const Text("Save Task"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
            minimumSize: const Size(170, 48),
          ),
          child: const Text("Cancel"),
        )
      ],
    );
  }

  SizedBox images() {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Container(
              width: 140,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 2,
                  color: selectedIndex == index ? Colors.greenAccent : Colors.grey,
                ),
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/${index}.png',
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget textBox(TextEditingController _controller, FocusNode _foucsNode, int line, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          maxLines: line,
          controller: _controller,
          focusNode: _foucsNode,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            hintText: text,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Color.fromARGB(31, 34, 185, 150),
                width: 2.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Colors.green,
                width: 2.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
