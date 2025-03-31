import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController textController;
  final VoidCallback onAdd;

  const DialogBox({
    super.key,
    required this.textController,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add new task"),
      content: TextField(
        controller: textController,
        decoration: InputDecoration(hintText: "Task name"),
      ),
      actions: [
        Row(
          children: [
            // Cancel button
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                textController.clear();
              },
              child: Text("Cancel"),
            ),

            SizedBox(width: 10),

            // Add button
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                onAdd();
              },
              child: Text("Add"),
            ),
          ],
        ),
      ],
    );
  }
}
