import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Pruba de cambios con git'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {

        },
        child: const Icon(Icons.add),
      ),
    );
  }
}