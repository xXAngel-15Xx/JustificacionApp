import 'package:flutter/material.dart';
import 'package:justificacion_app/src/pages/home_page.dart';

class FormPage extends StatefulWidget {
  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  String _numero = "";
  String _nombre = "";
  String _inicio = "";
  String _fin = "";
  String _motivo = "";
  String _grupo = "";
  String _seleccion = "Opcion 1";

  List _docentes = ['Opcion 1', 'Opcion 2', 'Opcion 3', 'Opcion 4', 'Opcion 5'];

  TextEditingController _inputDate = new TextEditingController();

  String dropdownValue = 'Opción 1';
  TextEditingController textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "JustificacionesApp",
          style: TextStyle(color: Colors.indigoAccent),
        ),
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 60, vertical: 20),
          children: <Widget>[
            Text(
              "Nueva Justificacion",
              style: TextStyle(fontSize: 40, color: Colors.indigoAccent),
              textAlign: TextAlign.center,
            ),
            SizedBox(width: 10, height: 50),
            _crearNumero(),
            Divider(),
            _crearnombre(),
            Divider(),
            _crearIni(),
            Divider(),
            _crearFin(),
            Divider(),
            _crearMotivo(context),
            Divider(),
            _crearGrupo(context),
            Divider(),
            _crearLista(),
            SizedBox(height: 16.0),
            _crearBoton(context),
          ],
        ),
      ),
    );
  }

  Widget _crearNumero() {
    return TextField(
      //autofocus: true,

      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: "No. de Control",
        labelText: "No. de Control",
      ),
      onChanged: (valor) {
        setState(() {
          _numero = valor;
        });
      },
    );
  }

  Widget _crearnombre() {
    return TextField(
      //autofocus: true,

      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: "Nombre Justificacion",
        labelText: "Nombre Justificacion",
      ),
      onChanged: (valor) {
        setState(() {
          _nombre = valor;
        });
      },
    );
  }

  Widget _crearIni() {
    return TextField(
      enableInteractiveSelection: false,
      controller: _inputDate,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: "Fecha de Inicio",
        labelText: "Fecha de Inicio",
        suffixIcon: Icon(Icons.calendar_month),
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _dateInicio(context);
      },
    );
  }

  _dateInicio(BuildContext context) async {
    DateTime picked = (await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(2000),
      lastDate: new DateTime(2025),
      locale: Locale('es', 'ES'),
    )) as DateTime;

    if (picked != null) {
      setState(() {
        _inicio = picked.toString();
        _inputDate.text = _inicio;
      });
    }
  }

  Widget _crearFin() {
    return TextField(
      enableInteractiveSelection: false,
      controller: _inputDate,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: "Fecha de Fin",
        labelText: "Fecha de Fin",
        suffixIcon: Icon(Icons.calendar_month),
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _dateFin(context);
      },
    );
  }

  _dateFin(BuildContext context) async {
    DateTime picked = (await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(2000),
      lastDate: new DateTime(2025),
      locale: Locale('es', 'ES'),
    )) as DateTime;

    if (picked != null) {
      setState(() {
        _fin = picked.toString();
        _inputDate.text = _fin;
      });
    }
  }

  Widget _crearMotivo(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: "Motivo",
        labelText: "Motivo",
      ),
      onChanged: (valor) {
        setState(() {
          _motivo = valor;
        });
      },
    );
  }

  Widget _crearGrupo(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: "Grupo",
        labelText: "Grupo",
      ),
      onChanged: (valor) {
        setState(() {
          _grupo = valor;
        });
      },
    );
  }

  Widget _crearLista() {
    return DropdownButton(
      value: _seleccion,
      items: getOpciones(),
      onChanged: (opt) {
        setState(() {
          _seleccion = opt!;
        });
      },
    );
  }

  List<DropdownMenuItem<String>> getOpciones() {
    List<DropdownMenuItem<String>> lista = [];
    _docentes.forEach((maestro) {
      lista.add(DropdownMenuItem(
        child: Text(maestro),
        value: maestro,
      ));
    });

    return lista;
  }
}

Widget _crearBoton(BuildContext context) {
  return ElevatedButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.indigoAccent),
    ),
    onPressed: () {
      final route = MaterialPageRoute(
        builder: (context) {
          return HomePage();
        },
      );
      Navigator.push(context, route);
    },
    child: Text('Enviar'),
  );
}
