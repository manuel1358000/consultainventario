import 'dart:async';
import 'package:casagriapp/src/models/existencia_model.dart';
import 'package:casagriapp/src/models/producto_model.dart';

class ProductoBloc{
  static final ProductoBloc _singleton = new ProductoBloc._internal();
  factory ProductoBloc(){
    return _singleton;
  }
  ProductoBloc._internal(){
  }
  final _productosStreamController = StreamController<List<ProductoModel>>.broadcast();
  Function(List<ProductoModel>) get productosSink => _productosStreamController.sink.add;
  Stream<List<ProductoModel>> get productoStream => _productosStreamController.stream;

  final _existenciasStreamController = StreamController<List<ExistenciaModel>>.broadcast();
  Function(List<ExistenciaModel>) get existenciaSink => _existenciasStreamController.sink.add;
  Stream<List<ExistenciaModel>> get existenciaStream => _existenciasStreamController.stream;

  disposeStreams(){
    _productosStreamController?.close();
    _existenciasStreamController?.close();
  }
}