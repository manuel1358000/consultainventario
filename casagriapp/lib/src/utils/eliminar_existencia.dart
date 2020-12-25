import 'package:casagriapp/src/models/producto_model.dart';
import 'package:casagriapp/src/models/sucursal_model.dart';
import 'package:casagriapp/src/pages/listado_existencias_page.dart';
import 'package:casagriapp/src/providers/existencia_provider.dart';
import 'package:casagriapp/src/providers/producto_provider.dart';
import 'package:casagriapp/src/utils/mensaje_widget.dart';
import 'package:casagriapp/src/utils/validacion.dart';
import 'package:flutter/material.dart';
TextEditingController _controllerExistencia=new TextEditingController();
final _formKey = GlobalKey<FormState>();
String existencia='';
ProductoProvider productoProvider = new ProductoProvider();
ExistenciaProvider existenciaProvider = new ExistenciaProvider();
  eliminarExistencia(BuildContext context,int idExistencia,SucursalModel sucursal, ProductoModel producto){
    final size = MediaQuery.of(context).size;
    existencia='';
    return showDialog(
      context: context,
      builder: (context){
        return Form(
          key: _formKey,
          child: AlertDialog(
            title: Text('Para eliminar una existencia ingrese la clave',style:TextStyle(color: Theme.of(context).primaryColor,fontFamily: 'fredoka',fontSize: size.height*0.02,fontWeight: FontWeight.normal)),
            content: TextFormField(
              keyboardType: TextInputType.visiblePassword,
              obscureText: false,
              controller: _controllerExistencia,
              decoration: InputDecoration(hintText: 'Ingrese Clave'),
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
                onPressed: existencia!=null? (){
                    if(_formKey.currentState.validate()){
                      if(existencia.compareTo('CASAGRI')==0){
                        _eliminarExistencia(context,idExistencia,sucursal,producto);
                        _controllerExistencia.text='';
                      }else{
                        mostrarAlerta(context, 'La clave no es correcta');
                      }
                    }
                  }:null,
                child: Text('ELIMINAR',style:TextStyle(color: Theme.of(context).primaryColor,fontFamily: 'fredoka',fontSize: size.height*0.02,fontWeight: FontWeight.normal)),
              )
            ],
          ),
        );
      }
    );
  }
  _eliminarExistencia(BuildContext context, int idExistencia,SucursalModel sucursal, ProductoModel producto)async{
    Map result= await existenciaProvider.eliminarExistencia(idExistencia);
    if(!result['estado']){
      mostrarAlerta(context, result['mensaje']);
      return null;
    } 
    Navigator.pop(context);
    Navigator.pushReplacement(context,new MaterialPageRoute(builder: (context)=>new ListadoExistenciasPage(sucursal: sucursal,producto: producto)));
    //mostrarAlerta(context,result['mensaje']);
  }
  