import 'dart:convert';
import 'dart:io';
import 'package:casagriapp/src/bloc/producto_bloc.dart';
import 'package:casagriapp/src/globales/globales.dart';
import 'package:casagriapp/src/models/producto_model.dart';
import 'package:casagriapp/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;
class ProductoProvider{
  PreferenciasUsuario preferenciasUsuario = new PreferenciasUsuario();
  //validaciones para los productos generales cargados
  bool _productoMas=true;
  bool _productoCargando=false;
  int paginacionProducto=0;
  List<ProductoModel> _productos = new List<ProductoModel>();

  int paginacionBuscar=0;

  Future<List<ProductoModel>>obtenerProductos()async {
    ProductoBloc productoBloc = new ProductoBloc();
    try{
      if(!_productoMas)return [];
      if(_productoCargando) return [];
      _productoCargando=true;
      final resp=await http.get(
        ipServer+'/listadoProductos?indice='+paginacionProducto.toString(),
        headers: {"Content-Type": "application/json"}
      );
      if(resp.statusCode!=200){
        return [];
      }else{
        Map<String,dynamic> decodedResp=json.decode(resp.body);
        if(!decodedResp['estado']){
          return [];
        }
        final productos = new Productos.fromJsonList(decodedResp['data']);
        paginacionProducto+=10;
        _productos.addAll(productos.items);
        productoBloc.productosSink(_productos);
        _productoCargando=false; 
        return _productos;
      }
    }catch(e){
      _productoCargando=false;
      _productoMas=false;
      return [];
    }
  }
  Future<Map<String, dynamic>> agregarExistencia(String cantidad,int idProducto,int idSucursal,) async {
    try{
      
      final authData={
        'cantidad':int.parse(cantidad),
        'idUsuario':preferenciasUsuario.codigo,
        'idProducto':idProducto,
        'idSucursal':idSucursal,
      };
      final resp=await http.post(
        ipServer+'/crearExistencia',
        body:json.encode(authData),
        headers: {"Content-Type":"application/json"}
      );
      if(resp.statusCode!=200){
        return {'estado':false,'mensaje':'Ocurrio un error al realizar la accion, intente nuevamente'};
      }
      Map<String,dynamic> decodedResp = json.decode(resp.body);
      return {'estado':true,'mensaje':decodedResp['mensaje']};
    }catch(e){
      return {'estado':false,'mensaje':'Contacte a el equipo de MicuponGT'};
    }
  }
  Future<List<ProductoModel>>buscarProductos(String query)async {
    await Future.delayed(Duration(milliseconds: 1000));
    try{
      final resp=await http.get(
        ipServer+'/buscarProducto?valor='+query,
        headers: {"Content-Type": "application/json"}
      );
      if(resp.statusCode!=200){
        return [];
      }else{
        Map<String,dynamic> decodedResp=json.decode(resp.body);
        if(!decodedResp['estado']){
          return [];
        }
        final productos = new Productos.fromJsonList(decodedResp['data']);
        return productos.items;
      }
    }catch(e){
      //_destacadosCargando=false;
      return [];
    }
  }
  Future<Map<String, dynamic>>sumaExistencia(int producto,int sucursal)async {
    try{
      final resp=await http.get(
        ipServer+'/sumaExistencias?sucursal='+sucursal.toString()+'&producto='+producto.toString(),
        headers: {"Content-Type": "application/json"}
      );
      if(resp.statusCode!=200){
        return {'estado':false,'mensaje':'Ocurrion un error al obtener el recurso'};
      }else{
        Map<String,dynamic> decodedResp=json.decode(resp.body);
        if(!decodedResp['estado']){
          return {'estado':false,'mensaje':'Ocurrion un error al obtener el recurso'};
        }
        List lista = decodedResp['data'];
      return {'estado':true,'totalproductos':lista[0]['totalproductos']??0};
      }
    }catch(e){
      //_destacadosCargando=false;
      return {'estado':false,'mensaje':'Ocurrion un error al obtener el recurso'};
    }
  }
  Future<Map<String, dynamic>>codigoEscanner(String valor)async {
    try{
      final resp=await http.get(
        ipServer+'/codigoEscaner?valor='+valor,
        headers: {"Content-Type": "application/json"}
      );
      if(resp.statusCode!=200){
        return {'estado':false,'mensaje':'Ocurrion un error al obtener el recurso'};
      }else{
        Map<String,dynamic> decodedResp=json.decode(resp.body);
        if(!decodedResp['estado']){
          return {'estado':false,'mensaje':'Ocurrion un error al obtener el recurso'};
        }
        ProductoModel producto = new ProductoModel.fromJson(decodedResp['data']);
      return {'estado':true,'producto':producto};
      }
    }catch(e){
      //_destacadosCargando=false;
      return {'estado':false,'mensaje':'Ocurrion un error al obtener el recurso'};
    }
  }
  

}