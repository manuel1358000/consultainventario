import 'package:casagriapp/src/models/sucursal_model.dart';
import 'package:casagriapp/src/pages/listado_productos_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SucursalWidget extends StatefulWidget {
  final List<SucursalModel> sucursales;
  SucursalWidget({@required this.sucursales});

  @override
  _SucursalWidgetState createState() => _SucursalWidgetState();
}

class _SucursalWidgetState extends State<SucursalWidget> {
  final _pageController=new PageController(
    initialPage: 1,
    viewportFraction: 0.30
  );
  SucursalModel sucursal;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: PageView.builder(
        scrollDirection: Axis.vertical,
        controller: _pageController,
        itemCount: widget.sucursales.length,
        itemBuilder:(context,i){
          sucursal=widget.sucursales[i];
          return _crearTarjeta(context,widget.sucursales[i]);
        } 
      ),
    );
  } 
  
  Widget _crearTarjeta(BuildContext context,SucursalModel sucursal){
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        top:size.width*0.02,
        left: size.width*0.025,
        right: size.width*0.025,
        bottom: size.width*0.02
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            spreadRadius: 10,
            blurRadius: 15
          )
        ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _crearIcono(context),
          _crearTitulo(context,sucursal),
          Divider(),
          _crearBoton(context,sucursal)
        ],
      )
    );
  }
  Widget _crearIcono(BuildContext context){
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        bottom: size.height*0.01,
        top: size.height*0.01
      ),
      child: Icon(FontAwesomeIcons.storeAlt,size: size.height*0.05,color: Theme.of(context).primaryColor),
    );
  }
  Widget _crearTitulo(BuildContext context,SucursalModel sucursal){
    final size = MediaQuery.of(context).size;
    return Container(
      child: Text(sucursal.nombre,textAlign: TextAlign.center,style:TextStyle(color: Theme.of(context).textSelectionColor,fontFamily: 'fredoka',fontSize: size.height*0.025,fontWeight: FontWeight.normal)),
    );
  }
  
  Widget _crearBoton(BuildContext context,SucursalModel sucursal){
    final size = MediaQuery.of(context).size;
    return FlatButton(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).primaryColor,
          style: BorderStyle.solid
        )
      ),
      onPressed: (){
        Navigator.push(context,new MaterialPageRoute(builder: (context)=>new ListadoProductosPage(sucursal: sucursal)));
      }, 
      child: Text('Ver Listado Productos',textAlign: TextAlign.center,style:TextStyle(color: Theme.of(context).primaryColor,fontFamily: 'fredoka',fontSize: size.height*0.015,fontWeight: FontWeight.normal)),
    );
  }
}