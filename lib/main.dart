import 'package:flutter/material.dart';
import 'package:justificacion_app/src/pages/forget_password_page.dart';
import 'package:justificacion_app/src/pages/formu_page.dart';
import 'package:justificacion_app/src/pages/home_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:justificacion_app/src/pages/login_page.dart';
import 'package:justificacion_app/src/pages/register_page.dart';
import 'package:justificacion_app/src/provider/ui_provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: ( _ ) => UIProvider() )
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
        'home'            : (context) => const HomePage(),
        'login'           : (context) => const LoginPage(),
        'register'        : (context) => const RegisterPage(),
        'forget-password' : (context) => const ForgetPasswordPage(),
        'form'            : (context) => FormPage(),
      },
      initialRoute: 'login',
    );
  }
}
