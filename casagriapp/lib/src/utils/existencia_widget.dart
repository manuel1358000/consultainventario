import 'package:casagriapp/src/models/producto_model.dart';
import 'package:casagriapp/src/models/sucursal_model.dart';
import 'package:casagriapp/src/pages/listado_existencias_page.dart';
import 'package:casagriapp/src/providers/producto_provider.dart';
import 'package:casagriapp/src/utils/mensaje_widget.dart';
import 'package:casagriapp/src/utils/validacion.dart';
import 'package:flutter/material.dart';
TextEditingController _controllerExistencia=new TextEditingController();
final _formKey = GlobalKey<FormState>();
String existencia='';
ProductoProvider productoProvider = new ProductoProvider();
  crearExistencia(BuildContext context,ProductoModel producto, SucursalModel sucursal){
    final size = MediaQuery.of(context).size;
    existencia='';
    return showDialog(
      context: context,
      builder: (context){
        return Form(
          key: _formKey,
          child: AlertDialog(
            title: Text(producto.codigoGenerado+'-'+producto.nombre,style:TextStyle(color: Theme.of(context).primaryColor,fontFamily: 'fredoka',fontSize: size.height*0.02,fontWeight: FontWeight.normal)),
            content: TextFormField(
              keyboardType: TextInputType.number,
              controller: _controllerExistencia,
              decoration: InputDecoration(hintText: 'Ingrese Una Cantidad'),
              onChanged: (value){
                existencia=value;
              },
              validator: validacionExistencia,
            ),
            actions: <Widget>[
              new FlatButton(
                onPressed: (){
                  _controllerExistencia.text='';
                  Navigator.of(context).pop();
                }, 
                child: Text('CANCELAR',style:TextStyle(color: Theme.of(context).primaryColor,fontFamily: 'fredoka',fontSize: size.height*0.02,fontWeight: FontWeight.normal)),
              ),
              new FlatButton(
                onPressed: existencia!=null ? (){
                    if(_formKey.currentState.validate()){
                      _agregarExistencia(context,existencia,producto,sucursal);
                      _controllerExistencia.text='';
                    }
                  }:null,
                child: Text('AGREGAR',style:TextStyle(color: Theme.of(context).primaryColor,fontFamily: 'fredoka',fontSize: size.height*0.02,fontWeight: FontWeight.normal)),
              )
            ],
          ),
        );
      }
    );
  }
  _agregarExistencia(BuildContext context, String existencia, ProductoModel producto, SucursalModel sucursal)async{
    Map result= await productoProvider.agregarExistencia(existencia, producto.idProducto, sucursal.idSucursal);
    if(!result['estado']){
      mostrarAlerta(context, result['mensaje']);
      return null;
    } 
    Navigator.pop(context);
    Navigator.pushReplacement(context,new MaterialPageRoute(builder: (context)=>new ListadoExistenciasPage(sucursal: sucursal,producto: producto)));
    //mostrarAlerta(context,result['mensaje']);
  }
  