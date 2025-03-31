import 'package:flutter/material.dart';
import 'package:flutter_hive/util/dialog_box.dart';
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
        onPressed:
            () => showDialog(
              context: context,
              builder:
                  (context) => DialogBox(
                    textController: _textController,
                    onAdd: addTodo,
                  ),
            ),
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
