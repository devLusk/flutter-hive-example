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
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("ToDo w/ Hive DB"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[900],
        foregroundColor: Colors.white,
      ),
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
        backgroundColor: Colors.blueGrey[700],
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final todo = todos[index];
            return Container(
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Colors.blueGrey[50],
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ListTile(
                title: Text(todo, style: TextStyle(fontSize: 16)),
                trailing: IconButton(
                  onPressed: () => deleteTodo(index),
                  icon: Icon(Icons.delete, color: Colors.red[300]),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
