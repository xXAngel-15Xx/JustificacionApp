
import 'package:flutter/material.dart';

class AlertDialogCustom extends StatelessWidget {
  final String title;
  final String message;

  const AlertDialogCustom({super.key, required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), 
              child: const Text('Aceptar')
            )
          ],
    );
  }
}