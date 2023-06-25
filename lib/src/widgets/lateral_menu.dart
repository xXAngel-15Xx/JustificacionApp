import 'package:flutter/material.dart';

import '../models/lateral_menu_option_model.dart';



class LateralMenu extends StatelessWidget {
  final menuOptions = [
    LateralMenuOption(route: 'logout', icon: Icons.logout_outlined, name: 'Cerrar Sesión'),
  ];

  LateralMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          children: _buildMenuOptions(context),
        ),
      ),
    );
  }

  List<Widget> _buildMenuOptions(BuildContext context) {
    List<Widget> lista = [];
    lista.add(
      const Padding(
        padding: EdgeInsets.only(left: 20.0, top: 40.0),
        child: Text('Menú'),
      )
    );
    lista.add(const SizedBox(height: 30.0));

    for(var item in menuOptions) {
      lista.add(
        ListTile(
          title: Text(item.name),
          leading: Icon(item.icon),
          onTap: () => Navigator.pushNamed(context, item.route),
          selected: ModalRoute.of(context)?.settings.name == item.route,
          selectedColor: Theme.of(context).colorScheme.onSecondaryContainer,
          selectedTileColor: Theme.of(context).colorScheme.secondaryContainer,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        )
      );
      lista.add(const SizedBox(height: 5.0,));
    }

    return lista;
  }
}