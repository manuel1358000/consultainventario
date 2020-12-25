import 'dart:convert';
class Productos{
  List<ProductoModel> items = new List();
  Productos();
  Productos.fromJsonList(List<dynamic> jsonList){ 
    if(jsonList==null)return ;
    for(var item in jsonList){
      ProductoModel producto = new ProductoModel.fromJson(item);
      items.add(producto);
    }
  }
}
ProductoModel productoModelFromJson(String str) => ProductoModel.fromJson(json.decode(str));
String productoModelToJson(ProductoModel data) => json.encode(data.toJson());
class ProductoModel {
    int idProducto;
    String codigoGenerado;
    String nombre;
    String unidadMedida;
    int existencia;
    
    ProductoModel({
      this.idProducto=0,
      this.codigoGenerado='',
      this.nombre='',
      this.unidadMedida='',
      this.existencia=0
    });
    factory ProductoModel.fromJson(Map<String, dynamic> json) => ProductoModel(
        idProducto: int.parse(json["idProducto"].toString())??0,
        codigoGenerado: json["codigoGenerado"]??'',
        nombre: json["nombre"]??'',
        unidadMedida: json["unidadMedida"]??'',
        existencia:0
    );
    Map<String, dynamic> toJson() => {
        "idProducto": idProducto,
        "codigoGenerado": codigoGenerado,
        "nombre": nombre,
        "unidadMedida": unidadMedida,
        "existencia":existencia
    };
}