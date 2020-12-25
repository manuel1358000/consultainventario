import 'dart:convert';
import 'package:casagriapp/src/globales/globales.dart';
import 'package:casagriapp/src/preferencias_usuario/preferencias_usuario.dart';
import "package:http/http.dart" as http;
class UsuarioProvider{
  PreferenciasUsuario _preferenciasUsuario=new PreferenciasUsuario();
  
  Future<Map<String, dynamic>> login(String usuario,String password)async{
    try{
      final resp=await http.get(
        ipServer+'/iniciarSesion?usuario='+usuario+'&contra='+password,
        headers: {"Content-Type":"application/json"}
      );
      if(resp.statusCode!=200){
        return 
        {'estado':false,'mensaje':'Ocurrio un error, no se pudo completar la peticion'};
      }
      Map<String,dynamic> decodedResp = json.decode(resp.body);
      if(decodedResp['estado']){
        _preferenciasUsuario.codigo=decodedResp['codigo'];
      }
      return decodedResp;
    }catch(e){
      return {'estado':false,'mensaje':'Contacte con el equipo de CASAGRI, S.A.'};
    } 
  }
  
  Future<Map<String, dynamic>> cerrarSesion()async{
    try{
      _preferenciasUsuario.codigo=0;
      return {'estado':true,'mensaje':'Se cerro sesion exitosamente en Gmail'};
    }catch(e){
      return {'estado':false,'mensaje':'Ocurro un error al cerrar sesion'};
    }
  }
}