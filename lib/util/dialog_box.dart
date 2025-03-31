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
      backgroundColor: Colors.white,
      title: Text("Add new task"),
      content: TextField(
        controller: textController,
        decoration: InputDecoration(hintText: "Task name"),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Cancel button
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey[700],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  textController.clear();
                },
                child: Text("Cancel"),
              ),
            ),

            SizedBox(width: 10),

            // Add button
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey[700],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  onAdd();
                },
                child: Text("Add"),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
