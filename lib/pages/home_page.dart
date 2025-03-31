import 'package:flutter/material.dart';
import 'package:hive_local_storage/hive_local_storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Controllers and variables
  final _testBox = Hive.box("testBox");
  final _textController = TextEditingController();
  List todos = [];

  @override
  void initState() {
    super.initState();
    // Load existing data or initialize with an empty list
    todos = _testBox.get("todoList") ?? [];
  }

  // Dialog box
  void openDialogBox() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Add new task"),
            content: TextField(
              controller: _textController,
              decoration: InputDecoration(hintText: "Task name"),
            ),
            actions: [
              Row(
                children: [
                  // Cancel button
                  ElevatedButton(
                    onPressed: Navigator.of(context).pop,
                    child: Text("Cancel"),
                  ),

                  SizedBox(width: 10),

                  // Add button
                  ElevatedButton(onPressed: null, child: Text("Add")),
                ],
              ),
            ],
          ),
    );
  }

  // Data manipulation methods
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: openDialogBox,
        child: Icon(Icons.add),
      ),
    );
  }
}
