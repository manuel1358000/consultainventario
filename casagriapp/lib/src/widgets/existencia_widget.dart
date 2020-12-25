import 'package:casagriapp/src/models/existencia_model.dart';
import 'package:casagriapp/src/models/producto_model.dart';
import 'package:casagriapp/src/models/sucursal_model.dart';
import 'package:casagriapp/src/utils/eliminar_existencia.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class ExistenciaWidget extends StatefulWidget {
  final ProductoModel producto;
  final SucursalModel sucursal;
  final List<ExistenciaModel> existencias;
  ExistenciaWidget({@required this.producto,@required this.sucursal,@required this.existencias});
  
  @override
  _ExistenciaWidgetState createState() => _ExistenciaWidgetState();
}
class _ExistenciaWidgetState extends State<ExistenciaWidget> {
  final _pageController=new PageController(
    initialPage: 0,
    viewportFraction: 0.13
  );
  static const menuItems = <String>['editar','eliminar'];
  ExistenciaModel existenciaModel;
  final List<PopupMenuItem<String>> _popUpMenuItems=menuItems.map(
    (String value)=>PopupMenuItem<String>(
      value:value,
      child: Text(value)
    )
  ).toList();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width*0.85,
      color: Colors.transparent,
      child: ListView.builder(
        controller: _pageController,
        itemCount: widget.existencias.length,
        itemBuilder: (context,i){
          existenciaModel=widget.existencias[i];
          return _crearExistencias(context, widget.existencias[i]);
        },
        scrollDirection: Axis.vertical,
      ),
    );
  }
  Widget _crearExistencias(BuildContext context, ExistenciaModel existencia){
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.all(Radius.circular(20.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            spreadRadius: 2.5,
            blurRadius: 5
          )
        ]
      ),
      margin: EdgeInsets.only(
        bottom:size.height*0.005,
        top:size.height*0.005,
        left:size.width*0.05,
        right:size.width*0.05,
      ),
      child: _crearInfo(context,existencia),
    );
  }
  Widget _crearInfo(BuildContext context,ExistenciaModel existencia){
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _crearUsuario(context,existencia),
            _crearFecha(context,existencia),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _crearCantidad(context,existencia),
            _crearMenuAcciones(context,existencia.idExistencia)
          ],
        )
      ],
    );
  }
  Widget _crearMenuAcciones(BuildContext context,int idExistencia){
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width*0.40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _crearEditar(context,idExistencia),
          _crearEliminar(context,idExistencia)
        ],
      ),
    );
  }
  Widget _crearEditar(BuildContext context, int idExistencia){
    return Container(
      child: IconButton(
        icon: Icon(FontAwesomeIcons.edit,color: Colors.blue), 
        onPressed: null
      ),
    );
  }
  Widget _crearEliminar(BuildContext context,int idExistencia){
    return Container(
      child: IconButton(
        icon: Icon(FontAwesomeIcons.trash,color: Colors.red), 
        onPressed: ()async{
          eliminarExistencia(context, idExistencia,widget.sucursal, widget.producto);
        }
      ),
    );
  }
  Widget _crearUsuario(BuildContext context,ExistenciaModel existencia){
    final size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Container(
          width: size.width*0.40,
          padding: EdgeInsets.only(
            left: size.width*0.04,
            right: size.width*0.04,
          ),
          child: Text(existencia.usuario,textAlign: TextAlign.center,style: TextStyle(fontSize: size.height*0.025,color:Theme.of(context).primaryColor,fontFamily: 'fredoka',fontWeight: FontWeight.normal)),
        ),
        Container(
          padding: EdgeInsets.only(
            left: size.width*0.04,
            right: size.width*0.04,
          ),
          child: Text('Usuario',textAlign: TextAlign.center,style: TextStyle(fontSize: size.height*0.015,color:Theme.of(context).textSelectionColor,fontFamily: 'fredoka',fontWeight: FontWeight.normal)),
        ),
        
      ],
    );
  }
  Widget _crearFecha(BuildContext context,ExistenciaModel existencia){
    final size = MediaQuery.of(context).size;
    String fecha=DateFormat('dd-MM-yyyy - kk:mm').format(existencia.fechaActualizacion);
    return Column(
      children: <Widget>[
        Container(
          width: size.width*0.40,
          padding: EdgeInsets.only(
            left: size.width*0.04,
            right: size.width*0.04,
          ),
          child: Text(fecha,textAlign: TextAlign.center,style: TextStyle(fontSize: size.height*0.0175,color:Theme.of(context).primaryColor,fontFamily: 'fredoka',fontWeight: FontWeight.normal)),
        ),
        Container(
          padding: EdgeInsets.only(
            left: size.width*0.04,
            right: size.width*0.04,
          ),
          child: Text('Fecha Actualizacion',textAlign: TextAlign.center,style: TextStyle(fontSize: size.height*0.015,color:Theme.of(context).textSelectionColor,fontFamily: 'fredoka',fontWeight: FontWeight.normal)),
        ),
      ],
    );
  }
  Widget _crearCantidad(BuildContext context,ExistenciaModel existencia){
    final size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Container(
          width: size.width*0.40,
          padding: EdgeInsets.only(
            left: size.width*0.04,
            right: size.width*0.04,
          ),
          child: Text(existencia.cantidad.toString(),textAlign: TextAlign.center,style: TextStyle(fontSize: size.height*0.035,color:Theme.of(context).primaryColor,fontFamily: 'fredoka',fontWeight: FontWeight.normal)),
        ),
        Container(
          padding: EdgeInsets.only(
            left: size.width*0.04,
            right: size.width*0.04,
          ),
          child: Text('Cantidad',textAlign: TextAlign.center,style: TextStyle(fontSize: size.height*0.015,color:Theme.of(context).textSelectionColor,fontFamily: 'fredoka',fontWeight: FontWeight.normal)),
        ),
      ],
    );
  }
}