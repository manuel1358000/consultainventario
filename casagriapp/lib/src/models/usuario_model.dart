import 'dart:convert';
import 'dart:io';
UsuarioModel usuarioModelFromJson(String str) => UsuarioModel.fromJson(json.decode(str));
String usuarioModelToJson(UsuarioModel data) => json.encode(data.toJson());
class UsuarioModel {
    String usuario;
    int codigo;
    String contra;
    String confirmacionContra;

    UsuarioModel({
      this.usuario="",
      this.codigo=0,
      this.contra="",
      this.confirmacionContra="",
    });
    factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
        usuario: json["nombres"]??'',
        codigo: int.parse(json["estado"].toString())??0,
        contra: json["tipo"]??'',
    );
    Map<String, dynamic> toJson() => {
        "usuario": usuario,
        "codigo": codigo,
        "contra":contra,
        "confirmacionContra":confirmacionContra
    };
}