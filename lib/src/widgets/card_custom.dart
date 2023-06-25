import 'package:flutter/material.dart';

import '../styles/styles.dart';

class CardCustom extends StatelessWidget {
  final String titulo;
  final String subtitulo;
  final Widget contenido;
  final void Function() onEliminar;
  final void Function() onEditar;

  const CardCustom({super.key, required this.titulo, required this.subtitulo, required this.contenido, required this.onEliminar, required this.onEditar});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: hedding3(),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  subtitulo,
                  style: textGraySmall(),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                contenido,
                const SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                        onPressed: onEliminar, child: const Text('Eliminar')),
                    const SizedBox(
                      width: 10.0,
                    ),
                    ElevatedButton(
                        onPressed: onEditar, child: const Text('Editar')),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
