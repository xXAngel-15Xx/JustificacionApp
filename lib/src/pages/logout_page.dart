import 'package:flutter/material.dart';
import 'package:justificacion_app/src/services/cuentas_service.dart';
import 'package:provider/provider.dart';

class LogoutPage extends StatefulWidget {
  const LogoutPage({super.key});

  @override
  State<LogoutPage> createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  @override
  void initState() {
    super.initState();
    
    Future.delayed(const Duration(seconds: 5), () async {
      await _logout();
    });
  }

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 10.0,),
            Text('Cerrando Sesión, vuelva pronto ;)'),
          ],
        ),
      ),
    );
  }

  _logout() async {
    final cuentasService = Provider.of<CuentasService>(context, listen: false);

    await cuentasService.logout();

    if(context.mounted) {
      Navigator.pushNamed(context, 'login');
    }
  }
}