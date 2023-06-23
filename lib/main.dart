import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:justificacion_app/src/pages/justificaciones_form_page.dart';
import 'package:justificacion_app/src/provider/justificaciones_form_provider.dart';
import 'package:justificacion_app/src/services/users_service.dart';

import 'package:provider/provider.dart';

import 'package:justificacion_app/src/pages/forget_password_page.dart';
import 'package:justificacion_app/src/pages/grupos_page.dart';
import 'package:justificacion_app/src/pages/justificaciones_page.dart';
import 'package:justificacion_app/src/pages/login_page.dart';
import 'package:justificacion_app/src/pages/register_page.dart';
import 'package:justificacion_app/src/provider/register_form_provider.dart';
import 'package:justificacion_app/src/services/cuentas_service.dart';
import 'package:justificacion_app/src/services/grupos_service.dart';
import 'package:justificacion_app/src/services/justificaciones_service.dart';

void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: ( _ ) => RegisterFormProvider() ),
      ChangeNotifierProvider(create: ( _ ) => JustificacionesFormProvider() ),
      ChangeNotifierProvider(create: ( _ ) => CuentasService(),),
      ChangeNotifierProvider(create: ( _ ) => JustificacionesService()),
      ChangeNotifierProvider(create: ( _ ) => GruposService()),
      ChangeNotifierProvider(create: ( _ ) => UsersService()),
    ],
    child: const MyApp(),
  )
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //esto es para el formato de fechas en el form_page
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'), // English
        Locale('es', 'ES'), // Spanish
      ],
      //hasta aqui
      debugShowCheckedModeBanner: false,
      title: 'Justificaciones App',
      routes: {
        'home'                            : (context) => const JustificacionesPage(),
        'grupos'                          : (context) => const GruposPage(),
        'login'                           : (context) => const LoginPage(),
        'register'                        : (context) => const RegisterPage(),
        'forget-password'                 : (context) => const ForgetPasswordPage(),
        'justificaciones-form'            : (context) => const JustificacionesFormPage(),
      },
      initialRoute: 'login',
    );
  }
}
