import 'package:flutter/material.dart';
import 'package:justificacion_app/src/services/grupos_service.dart';
import 'package:justificacion_app/src/styles/styles.dart';
import 'package:justificacion_app/src/widgets/alert_dialog_custom.dart';
import 'package:justificacion_app/src/widgets/card_custom.dart';
import 'package:justificacion_app/src/widgets/lateral_menu.dart';
import 'package:provider/provider.dart';

import '../models/grupo_model.dart';

class GruposPage extends StatefulWidget {
  const GruposPage({
    super.key,
  });

  @override
  State<GruposPage> createState() => _GruposPageState();
}

class _GruposPageState extends State<GruposPage> {
  final _myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      _initPage();
    });
  }

  _initPage() async {
    final gruposService = Provider.of<GruposService>(context, listen: false);
    await gruposService.searchGrupos();
  }

  @override
  Widget build(BuildContext context){
    final gruposService = Provider.of<GruposService>(context, listen: false);
    final isLoading = context.select((GruposService g) => g.isLoading);
    
    return GestureDetector(
      onTap: () {
        if(_myFocusNode.hasFocus) {
          _myFocusNode.unfocus();
        }
      },
      child: Scaffold(
        drawer: LateralMenu(),
        appBar: AppBar(
          title: const Text('JustificacionesApp'),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, 'grupos-form');
          },
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: const Icon(Icons.add, color: blue, size: 25.0,),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Grupos', style: hedding1(),),
                  const SizedBox(height: 20.0,),
                  TextField(
                    focusNode: _myFocusNode,
                    decoration: InputDecoration(
                      label: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text('Buscar Grupo', style: textGrayMedium()),
                      ),
                      fillColor: const Color(0xffece6f0),
                      filled: true,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide: BorderSide.none
                      ),
                    ),
                    onSubmitted: (value) async {
                      gruposService.searchGrupos(searchTerm: value);
                    },
                  ),
                  const SizedBox(height: 40.0,),
                  StreamBuilder(
                    stream: gruposService.searchGruposStream,
                    builder: ( _, AsyncSnapshot<List<GruposModel>> snapshot) {
                      if(!snapshot.hasData || isLoading) {
                        return const Column(
                          children: [
                            Text('Buscando Grupos'),
                            SizedBox(height: 10.0,),
                            CircularProgressIndicator()
                          ],
                        );
                      }

                      if(snapshot.data != null) {
                        if(snapshot.data!.isEmpty) {
                          return const Text('Sin resultados');
                        }
                      }

                      return Column(
                        children: snapshot.data!.map((e) => CardCustom(
                          titulo: e.nombre, 
                          subtitulo: 'id: ${e.id}', 
                          contenido: SizedBox(
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text('Aula: ${e.aula}',),
                                const SizedBox(height: 10.0,),
                                Text('Semestre: ${e.semestre}'),
                                const SizedBox(height: 10.0,),
                                Text('Carrera: ${e.carrera}'),
                              ],
                            ),
                          ), 
                          onEliminar: () async {
                            final response = await gruposService.eliminar(e.id);

                            if(response.success) {
                              if(context.mounted) {
                                showDialog(context: context, builder: ( _ ) => AlertDialogCustom(title: '¡Correcto!', message: response.message));
                              }
                              await gruposService.searchGrupos();
                            } else {
                              if(context.mounted) {
                                showDialog(context: context, builder: ( _ ) => AlertDialogCustom(title: '¡Error!', message: response.message));
                              }
                            }
                          }, 
                          onEditar: () {
                            Navigator.pushNamed(context, 'grupos-form', arguments: e);
                          })
                        ).toList(),
                      );
                    }
                  )
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}
