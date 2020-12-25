import 'dart:convert';
class Existencias{
  List<ExistenciaModel> items = new List();
  Existencias();
  Existencias.fromJsonList(List<dynamic> jsonList){ 
    if(jsonList==null)return ;
    for(var item in jsonList){
      ExistenciaModel producto = new ExistenciaModel.fromJson(item);
      items.add(producto);
    }
  }
}
ExistenciaModel productoModelFromJson(String str) => ExistenciaModel.fromJson(json.decode(str));
String productoModelToJson(ExistenciaModel data) => json.encode(data.toJson());
class ExistenciaModel {
    int cantidad;
    int idProducto;
    int idSucursal;
    DateTime fechaActualizacion;
    int idUsuario;
    String usuario;
    int idExistencia;
    ExistenciaModel({
      this.cantidad=0,
      this.idProducto=0,
      this.idSucursal=0,
      this.fechaActualizacion,
      this.idUsuario=0,
      this.usuario='',
      this.idExistencia=0
    });
    factory ExistenciaModel.fromJson(Map<String, dynamic> json) => ExistenciaModel(
        cantidad:int.parse(json["cantidad"].toString())??0,
        idProducto:int.parse(json["idProducto"].toString())??0,
        idSucursal: int.parse(json["idSucursal"].toString())??0,
        fechaActualizacion: DateTime.parse(json['updatedAt'].toString())??'',
        idUsuario: int.parse(json['usuario']["idUsuario"].toString())??0,
        usuario:json['usuario']["usuario"]??'',
        idExistencia: int.parse(json["id"].toString())??0,
    );
    Map<String, dynamic> toJson() => {
      "cantidad":cantidad,
      "idProducto":idProducto,
      "idSucursal":idSucursal,
      "fechaActualizacion":fechaActualizacion,
      "idUsuario":idUsuario,
      "usuario":usuario,
      "idExistencia":idExistencia
    };
}