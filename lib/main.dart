import 'package:flutter/material.dart';
import 'package:justificacion_app/src/pages/formu_page.dart';
import 'package:justificacion_app/src/pages/home_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //esto es para el formato de fechas en el form_page
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', 'US'), // English
        Locale('es', 'ES'), // Spanish
      ],
      //hasta aqui
      debugShowCheckedModeBanner: false,
      title: 'Justificaciones App',
      routes: {
        'home': (context) => const HomePage(),
        'form': (context) => FormPage(),
      },
      initialRoute: 'form',
    );
  }
}
