import 'dart:convert';
import 'package:casagriapp/src/globales/globales.dart';
import 'package:casagriapp/src/models/sucursal_model.dart';
import 'package:casagriapp/src/preferencias_usuario/preferencias_usuario.dart';
import "package:http/http.dart" as http;
class SucursalProvider{
  
  Future<Map<String, dynamic>> obtenerSucursales()async{
    try{
      final resp=await http.get(
        ipServer+'/obtenerSucursales',
        headers: {"Content-Type":"application/json"}
      );
      if(resp.statusCode!=200){
        return 
        {'estado':false,'mensaje':'Ocurrio un error, no se pudo completar la peticion'};
      }
      Map<String,dynamic> decodedResp = json.decode(resp.body);
      List<SucursalModel> sucursales=Sucursales.fromJsonList(decodedResp['data']).items;
      return {'estado':true,'sucursales':sucursales};
    }catch(e){
      return {'estado':false,'mensaje':'Contacte con el equipo de CASAGRI, S.A.'};
    } 
  }
}