import 'package:flutter/material.dart';
import 'package:justificacion_app/src/provider/db_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Desde HomePage'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print(await DBProvider.db.nuevoGrupo());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}