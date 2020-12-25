import 'package:flutter/material.dart';
mostrarAlerta(BuildContext context,String mensaje){
  showDialog(
    context: context,
    builder: (context){
      return AlertDialog(
        title: Text('Info'),
        content: Text(mensaje),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: ()=>Navigator.of(context).pop(),
          ),
        ],
      );
    }
  );
}