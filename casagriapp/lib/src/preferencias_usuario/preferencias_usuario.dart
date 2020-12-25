import 'package:shared_preferences/shared_preferences.dart';
class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();
  factory PreferenciasUsuario() {
    return _instancia;
  }
  PreferenciasUsuario._internal();
  SharedPreferences _prefs;
  
  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }
  get codigo {
    return _prefs.getInt('codigo')??0;
  }
  set codigo( int value ) {
    _prefs.setInt('codigo', value);
  }
}