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
                    onPressed: () {
                      Navigator.pop(context);
                      _textController.clear();
                    },
                    child: Text("Cancel"),
                  ),

                  SizedBox(width: 10),

                  // Add button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      addTodo();
                    },
                    child: Text("Add"),
                  ),
                ],
              ),
            ],
          ),
    );
  }

  // Data manipulation methods
  void addTodo() {
    String todo = _textController.text;
    if (todo.isNotEmpty) {
      setState(() {
        todos.add(todo);
        _textController.clear();
      });
      saveDataBase();
    }
  }

  void deleteTodo(int index) {
    setState(() {
      todos.removeAt(index);
    });
    saveDataBase();
  }

  void saveDataBase() {
    _testBox.put("todoList", todos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Add button
      floatingActionButton: FloatingActionButton(
        onPressed: openDialogBox,
        child: Icon(Icons.add),
      ),

      // ListView of todos
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return ListTile(
            title: Text(todo),
            trailing: IconButton(
              onPressed: () => deleteTodo(index),
              icon: Icon(Icons.delete),
            ),
          );
        },
      ),
    );
  }
}
