import 'package:flutter/material.dart';
import 'package:justificacion_app/src/provider/register_form_provider.dart';
import 'package:provider/provider.dart';

class RadioButtonsUser extends StatefulWidget {
  const RadioButtonsUser({super.key});

  @override
  State<RadioButtonsUser> createState() => _RadioButtonsUserState();
}



class _RadioButtonsUserState extends State<RadioButtonsUser> {

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        _radioBtn(TypeUser.alumno, 'Alumno'),
        _radioBtn(TypeUser.profesor, 'Profesor')
      ],
    );
  }
  Widget _radioBtn(TypeUser user, String label) {
    final registerFormProvider = Provider.of<RegisterFormProvider>(context);
    return ListTile(
            title: Text(label),
            leading: Radio<TypeUser>(
              value: user,
              groupValue: registerFormProvider.typeUserSelected,
              onChanged: (TypeUser? value) {
                setState(() {
                  registerFormProvider.changeUserSelected(value);
                });
              },
            ),
          );
  }
}

