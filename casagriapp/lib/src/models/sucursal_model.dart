import 'dart:convert';
class Sucursales{
  List<SucursalModel> items = new List();
  Sucursales();
  Sucursales.fromJsonList(List<dynamic> jsonList){ 
    if(jsonList==null)return ;
    for(var item in jsonList){
      SucursalModel categoria = new SucursalModel.fromJson(item);
      items.add(categoria);
    }
  }
}
SucursalModel sucursalModelFromJson(String str) => SucursalModel.fromJson(json.decode(str));
String sucursalModelToJson(SucursalModel data) => json.encode(data.toJson());
class SucursalModel {
    int idSucursal;
    String nombre;
    
    SucursalModel({
      this.nombre="",
      this.idSucursal=0,
    });
    factory SucursalModel.fromJson(Map<String, dynamic> json) => SucursalModel(
        nombre: json["nombre"]??'',
        idSucursal: int.parse(json["idSucursal"].toString())??0,
    );
    Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "idSucursal": idSucursal
    };
}