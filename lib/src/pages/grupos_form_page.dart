import 'package:flutter/material.dart';
import 'package:justificacion_app/src/services/grupos_service.dart';
import 'package:justificacion_app/src/styles/styles.dart';
import 'package:justificacion_app/src/widgets/alert_dialog_custom.dart';
import 'package:provider/provider.dart';

import '../models/grupo_model.dart';

class GruposFormPage extends StatelessWidget {
  const GruposFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    GruposModel? grupoRoute = ModalRoute.of(context)?.settings.arguments as GruposModel?;
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    bool isCreateMode;
    final gruposService = Provider.of<GruposService>(context);
    final isLoadingCreateOrUpdated = context.select((GruposService g) => g.isLoadingCreateOrUpdated);

    if(grupoRoute == null) {
      isCreateMode = true;
      grupoRoute = GruposModel(id: 0, nombre: '', semestre: '', carrera: '', aula: '');
    } else {
      isCreateMode = false;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('JustificacionesApp'),
        centerTitle: true,
      ),
      body: isLoadingCreateOrUpdated ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(isCreateMode ? 'Creando Grupo' : 'Actualizando Grupo', style: hedding3()),
            const SizedBox(height: 10.0,),
            const CircularProgressIndicator()
          ],
        ),
      ) 
      : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isCreateMode ? Text('Crear Grupo', style: hedding2(),) : Text('Editar Grupo', style: hedding2(),),
                  ],
                ),
                const SizedBox(height: 40.0,),
                TextFormField(
                  initialValue: grupoRoute.nombre,
                  decoration: inputWithBorder('Nombre'),
                  onChanged: (value) => grupoRoute!.nombre = value,
                  validator: (value) {
                    if(value == null) {
                      return 'El campo Nombre es requerido.';
                    }
                    if(value.isEmpty) {
                      return 'El campo no puede ir vacio.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0,),
                TextFormField(
                  initialValue: grupoRoute.carrera,
                  decoration: inputWithBorder('Carrera'),
                  onChanged: (value) => grupoRoute!.carrera = value,
                  validator: (value) {
                    if(value == null) {
                      return 'El campo Carrera es requerido.';
                    }
                    if(value.isEmpty) {
                      return 'El campo no puede ir vacio.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0,),
                TextFormField(
                  initialValue: grupoRoute.semestre,
                  decoration: inputWithBorder('Semestre'),
                  onChanged: (value) => grupoRoute!.semestre = value,
                  validator: (value) {
                    if(value == null) {
                      return 'El campo Semestre es requerido.';
                    }
                    if(value.isEmpty) {
                      return 'El campo no puede ir vacio.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0,),
                TextFormField(
                  initialValue: grupoRoute.aula,
                  decoration: inputWithBorder('Aula'),
                  onChanged: (value) => grupoRoute!.aula = value,
                  validator: (value) {
                    if(value == null) {
                      return 'El campo Aula es requerido.';
                    }
                    if(value.isEmpty) {
                      return 'El campo no puede ir vacio.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0,),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (isCreateMode) 
                      Expanded(
                        child: ElevatedButton(
                        onPressed: () async {
                          final bool isValidForm = formKey.currentState?.validate() ?? false;

                          if(!isValidForm) {
                            showDialog(context: context, builder: ( _ ) => 
                              const AlertDialogCustom(title: '¡Error!', message: 'El formularios no es valido, revisa tus datos y vuelve a intentarlo.',));
                            return;
                          }

                          if(grupoRoute == null) return;

                          final response = await gruposService.crear(grupoRoute);

                          if(response.success) {
                            gruposService.searchGrupos();
                            if(context.mounted) {
                              Navigator.pop(context);
                              showDialog(context: context, builder: ( _ ) => 
                              AlertDialogCustom(title: '¡Correcto!', message: response.message));
                            }
                          } else {
                            if(context.mounted) {
                              showDialog(context: context, builder: ( _ ) => 
                              AlertDialogCustom(title: '¡Error!', message: response.message));
                            }
                          }
                        },
                        style: btnPurple(),
                        child: const Text('Crear')),
                      ) 
                    else 
                      Expanded(
                        child: ElevatedButton(
                        onPressed: () async {
                          final bool isValidForm = formKey.currentState?.validate() ?? false;

                          if(!isValidForm) {
                            showDialog(context: context, builder: ( _ ) => 
                              const AlertDialogCustom(title: '¡Error!', message: 'El formularios no es valido, revisa tus datos y vuelve a intentarlo.',));
                            return;
                          }

                          if(grupoRoute == null) return;

                          final response = await gruposService.actualizar(grupoRoute.id, grupoRoute);

                          if(response.success) {
                            gruposService.searchGrupos();
                            if(context.mounted) {
                              Navigator.pop(context);
                              showDialog(context: context, builder: ( _ ) => 
                              AlertDialogCustom(title: '¡Correcto!', message: response.message));
                            }
                          } else {
                            if(context.mounted) {
                              showDialog(context: context, builder: ( _ ) => 
                              AlertDialogCustom(title: '¡Error!', message: response.message));
                            }
                          }
                        }, 
                        style: btnPurple(),
                        child: const Text('Actualizar')),
                      )
                  ],
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}