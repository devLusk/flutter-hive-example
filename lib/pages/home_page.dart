import 'package:flutter/material.dart';
import 'package:hive_local_storage/hive_local_storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Get the box
  final _testBox = Hive.box("testBox");

  // Text controller (to get user input)
  final _textController = TextEditingController();

  // list of todos
  List todos = [];

  @override
  void initState() {
    // load data, if none exist then default to empty list
    todos = _testBox.get("todoList") ?? [];

    super.initState();
  }

  // add new todo

  // delete todo

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
