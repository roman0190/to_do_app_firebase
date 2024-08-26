import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:to_do_app_firebase/screens/add_note_page.dart';
import 'package:to_do_app_firebase/widgets/task_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool show = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
        visible: show,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AddNotePage(),
              ),
            );
          },
          backgroundColor: Colors.greenAccent,
          child: const Icon(
            Icons.add,
            size: 30,
          ),
        ),
      ),
      body: SafeArea(
        child: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (notification.direction == ScrollDirection.forward) {
              setState(() {
                show = true;
              });
            }
            if (notification.direction == ScrollDirection.reverse) {
              setState(() {
                show = false;
              });
            }
            return true;
          },
          child: ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) {
              return const TaskWidgets();
            },
          ),
        ),
      ),
    );
  }
}
