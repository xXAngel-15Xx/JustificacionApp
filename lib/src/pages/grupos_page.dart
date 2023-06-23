import 'package:flutter/material.dart';
import 'package:justificacion_app/src/services/cuentas_service.dart';
import 'package:justificacion_app/src/services/storage_service.dart';
import 'package:justificacion_app/src/widgets/alert_dialog_custom.dart';
import 'package:provider/provider.dart';

class GruposPage extends StatelessWidget {
  const GruposPage({
    super.key,
  });

  @override
  Widget build(BuildContext context){
    final cuentasService = Provider.of<CuentasService>(context);
    final storageService = StorageService.getInstace(); 

    return Scaffold(
      appBar: AppBar(
        title: const Text('JustificacionesApp'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton<int>(
            itemBuilder: (context) => <PopupMenuEntry<int>>[
            const PopupMenuItem(value: 1,child: Text('Cerrar Sesión'),)
          ],
          onSelected: (value) async {
            switch(value) {
              case 1:
                await cuentasService.logout();
                if(context.mounted) {
                  Navigator.pop(context);
                  showDialog(context: context, builder: ( _ ) => const AlertDialogCustom(title: '¡Adios!', message: 'Vuelve pronto :D'));
                }
              break;
            }
          },
        )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Bienvenido ${storageService.getUserFullName()}',
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Grupos',
                    style: TextStyle(fontSize: 36),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Buscar justificación',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Justificación ${index + 1}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.check),
                        onPressed: () {
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
