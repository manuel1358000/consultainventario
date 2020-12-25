
import 'package:casagriapp/src/pages/crear_existencia_page.dart';
import 'package:casagriapp/src/pages/inicio_page.dart';
import 'package:casagriapp/src/pages/listado_productos_page.dart';
import 'package:casagriapp/src/pages/login_page.dart';
import 'package:casagriapp/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

String ruta='login';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  final _prefs = new PreferenciasUsuario();
  await _prefs.initPrefs(); 
  if(_prefs.codigo!=0){
    ruta = 'inicio';
  } 
  runApp(MyApp());
} 

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en','US'),
        const Locale('es','ES'),
        const Locale.fromSubtags(languageCode: 'zh'),
      ],
      debugShowCheckedModeBanner: false,
      title: 'CASAGRIAPP',
      //initialRoute: 'stepper',
      initialRoute: ruta,
      routes: {
        'login': (BuildContext context) =>LoginPage(),
        'inicio': (BuildContext context) =>InicioPage(),
        'listadoProductos': (BuildContext context) =>ListadoProductosPage(),
        'crearExistencia': (BuildContext context) =>CrearExistenciaPage(),
      },
      theme:ThemeData(
        primaryColor: Color(0xFF2C8F3B),
        //primaryColor: Color(0xFF5F4AB6),
        accentColor: Color(0xFF00A9EB),
        textSelectionColor: Color(0xFF16181E),
        backgroundColor: Color(0xFFFFFFFF)
      ),
    );
  }
}