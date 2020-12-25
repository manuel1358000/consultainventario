import 'dart:convert';
import 'package:casagriapp/src/bloc/producto_bloc.dart';
import 'package:casagriapp/src/globales/globales.dart';
import 'package:casagriapp/src/models/existencia_model.dart';
import 'package:casagriapp/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;
class ExistenciaProvider{
  PreferenciasUsuario preferenciasUsuario = new PreferenciasUsuario();
  //validaciones para los productos generales cargados
  bool _existenciaMas=true;
  bool _existenciaCargando=false;
  int paginacionExistencia=0;
ProductoBloc productoBloc = new ProductoBloc();
  Future<List<ExistenciaModel>>obtenerExistencias(int idProducto,int idSucursal)async {
    try{
      final resp=await http.get(
        ipServer+'/obtenerExistencias?idProducto='+idProducto.toString()+'&idSucursal='+idSucursal.toString(),
        headers: {"Content-Type": "application/json"}
      );
      if(resp.statusCode!=200){
        return [];
      }else{
        Map<String,dynamic> decodedResp=json.decode(resp.body);
        if(!decodedResp['estado']){
          return [];
        }
        final existencias = new Existencias.fromJsonList(decodedResp['data']);
        return existencias.items;
      }
    }catch(e){
      return [];
    }
  }
  Future<Map<String, dynamic>>eliminarExistencia(int idExistencia)async {
    try{
      final resp=await http.delete(
        ipServer+'/eliminarExistencia?id='+idExistencia.toString(),
        headers: {"Content-Type": "application/json"}
      );
      if(resp.statusCode!=200){
        return {'estado':false,'mensaje':'Ocurrion un error al obtener el recurso'};
      }else{
        Map<String,dynamic> decodedResp=json.decode(resp.body);
        if(!decodedResp['estado']){
          return {'estado':false,'mensaje':'Ocurrion un error al obtener el recurso'};
        }
      return {'estado':true,'mensaje':decodedResp['mensaje']};
      }
    }catch(e){
      //_destacadosCargando=false;
      return {'estado':false,'mensaje':'Ocurrion un error al obtener el recurso'};
    }
  }
}