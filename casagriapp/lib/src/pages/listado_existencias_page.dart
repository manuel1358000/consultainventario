import 'package:casagriapp/src/bloc/producto_bloc.dart';
import 'package:casagriapp/src/models/existencia_model.dart';
import 'package:casagriapp/src/models/producto_model.dart';
import 'package:casagriapp/src/models/sucursal_model.dart';
import 'package:casagriapp/src/providers/existencia_provider.dart';
import 'package:casagriapp/src/providers/producto_provider.dart';
import 'package:casagriapp/src/utils/existencia_widget.dart';
import 'package:casagriapp/src/widgets/existencia_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListadoExistenciasPage extends StatefulWidget {
  SucursalModel sucursal;
  ProductoModel producto;
  ListadoExistenciasPage({@required this.sucursal,@required this.producto});
  @override
  _ListadoExistenciasPageState createState() => _ListadoExistenciasPageState();
}

class _ListadoExistenciasPageState extends State<ListadoExistenciasPage> {
  ExistenciaProvider existenciaProvider = new ExistenciaProvider();
  ProductoBloc productoBloc = new ProductoBloc();
  ProductoProvider productoProvider = new ProductoProvider();
  @override
  Widget build(BuildContext context) {
   
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Listado Existencias',style: TextStyle(fontSize: size.height*0.025,color:Theme.of(context).backgroundColor,fontFamily: 'fredoka')),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _crearListado(context)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
            crearExistencia(context,widget.producto,widget.sucursal);
        },
        heroTag: 'asd',
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(FontAwesomeIcons.plus,color: Theme.of(context).backgroundColor)
      ),
    );
  }
  Widget _crearFondo(BuildContext context){
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
    );
  }
  Widget _crearListado(BuildContext context){
    return Column(
      children: <Widget>[
        _crearInfo(context),
        _crearListadoExistencias(context)
      ],
    );
  }
  Widget _crearInfo(BuildContext context){
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
        top: size.height*0.03,
        left: size.width*0.05,
        right: size.width*0.05,
        bottom: size.height*0.02,
      ),
      child: GestureDetector(
        onTap: (){
          print('Se lanza el search delegate');
        },
        child: Column(
          children: <Widget>[
            _crearNombre(context),
            _crearDatosProducto(context),
            _crearDatosProducto2(context),
          ],
        )
      ),
    );
  }
  Widget _crearNombre(BuildContext context){
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(
        left: size.width*0.04,
        right: size.width*0.04,
        top: size.width*0.03
      ),
      child: Text(widget.producto.nombre,textAlign: TextAlign.center,style: TextStyle(fontSize: size.height*0.025,color:Theme.of(context).textSelectionColor,fontFamily: 'fredoka',fontWeight: FontWeight.bold)),
    );
  }
  Widget _crearDatosProducto(BuildContext context){
    return Container(
      child: Row(
        children: <Widget>[
          _crearUnidadMedida(context),
          _crearCodigo(context)
        ],
      ),
    );
  }
  Widget _crearUnidadMedida(BuildContext context){
    final size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Container(
          width: size.width*0.40,
          padding: EdgeInsets.only(
            left: size.width*0.04,
            right: size.width*0.04,
          ),
          child: Text(widget.producto.unidadMedida,textAlign: TextAlign.center,style: TextStyle(fontSize: size.height*0.025,color:Theme.of(context).primaryColor,fontFamily: 'fredoka',fontWeight: FontWeight.normal)),
        ),
        Container(
          padding: EdgeInsets.only(
            left: size.width*0.04,
            right: size.width*0.04,
          ),
          child: Text('Unidad Medida',textAlign: TextAlign.center,style: TextStyle(fontSize: size.height*0.015,color:Theme.of(context).textSelectionColor,fontFamily: 'fredoka',fontWeight: FontWeight.normal)),
        ),
      ],
    );
  }
  Widget _crearCodigo(BuildContext context){
     final size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Container(
          width: size.width*0.40,
          padding: EdgeInsets.only(
            left: size.width*0.04,
            right: size.width*0.04,
          ),
          child: Text(widget.producto.codigoGenerado,textAlign: TextAlign.center,style: TextStyle(fontSize: size.height*0.025,color:Theme.of(context).primaryColor,fontFamily: 'fredoka',fontWeight: FontWeight.normal)),
        ),
        Container(
          padding: EdgeInsets.only(
            left: size.width*0.04,
            right: size.width*0.04,
          ),
          child: Text('Codigo',textAlign: TextAlign.center,style: TextStyle(fontSize: size.height*0.015,color:Theme.of(context).textSelectionColor,fontFamily: 'fredoka',fontWeight: FontWeight.normal)),
        ),
      ],
    );
  }
  Widget _crearDatosProducto2(BuildContext context){
    return Container(
      child: Row(
        children: <Widget>[
          _crearSucursal(context),
          _crearCantidad(context)
        ],
      ),
    );
  }
  Widget _crearSucursal(BuildContext context){
    final size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Container(
          width: size.width*0.40,
          padding: EdgeInsets.only(
            left: size.width*0.04,
            right: size.width*0.04,
          ),
          child: Text(widget.sucursal.nombre,textAlign: TextAlign.center,style: TextStyle(fontSize: size.height*0.025,color:Theme.of(context).primaryColor,fontFamily: 'fredoka',fontWeight: FontWeight.normal)),
        ),
        Container(
          padding: EdgeInsets.only(
            left: size.width*0.04,
            right: size.width*0.04,
          ),
          child: Text('Sucursal',textAlign: TextAlign.center,style: TextStyle(fontSize: size.height*0.015,color:Theme.of(context).textSelectionColor,fontFamily: 'fredoka',fontWeight: FontWeight.normal)),
        ),
      ],
    );
  }
  Widget _crearCantidad(BuildContext context){
    final size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        _crearObtenerExistencia(context),
        Container(
          padding: EdgeInsets.only(
            left: size.width*0.04,
            right: size.width*0.04,
          ),
          child: Text('Existencias',textAlign: TextAlign.center,style: TextStyle(fontSize: size.height*0.015,color:Theme.of(context).textSelectionColor,fontFamily: 'fredoka',fontWeight: FontWeight.normal)),
        ),
      ],
    );
  }
  Widget _crearObtenerExistencia(BuildContext context){
    final size = MediaQuery.of(context).size;
    return FutureBuilder(
      future:productoProvider.sumaExistencia(widget.producto.idProducto,widget.sucursal.idSucursal),
      builder: (BuildContext context, AsyncSnapshot <Map<String, dynamic>> snapshot){
        if(snapshot.hasError){
          return Center(
            child: Text('Ocurrió un error, por favor vuelve a intentarlo')
          );
        }
        switch(snapshot.connectionState){
          case ConnectionState.none:
            return Container();
          case ConnectionState.waiting:
            return Center(child:CircularProgressIndicator());
          case ConnectionState.active:
            return Container();
          case ConnectionState.done:
            if(snapshot.data.length==0){
              return Container();
            }
            return Container(
              width: size.width*0.40,
              padding: EdgeInsets.only(
                left: size.width*0.04,
                right: size.width*0.04,
              ),
              child: Text(snapshot.data['totalproductos']==null?'0':snapshot.data['totalproductos'].toString(),textAlign: TextAlign.center,style: TextStyle(fontSize: size.height*0.03,color:Theme.of(context).primaryColor,fontFamily: 'fredoka',fontWeight: FontWeight.normal)),
            ); 
          default:
            return Container();
        }
      }
    );  
  }
  Widget _crearListadoExistencias(BuildContext context){
    final size = MediaQuery.of(context).size;
    return Expanded(
      flex: 1,
      child: Container(
        width: size.width,
        color: Colors.white,
        child: _crearExistencias(context),
      ),
    );
  }
  Widget _crearExistencias(BuildContext context){
    return FutureBuilder(
      future: existenciaProvider.obtenerExistencias(widget.producto.idProducto,widget.sucursal.idSucursal),
      builder: (BuildContext context, AsyncSnapshot <List<ExistenciaModel>> snapshot){
        if(snapshot.hasError){
          return Center(
            child: Text('Ocurrió un error, por favor vuelve a intentarlo')
          );
        }
        switch(snapshot.connectionState){
          case ConnectionState.none:
            return Container();
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            if(snapshot.data.length==0){
              return Container();
            }
            return ExistenciaWidget(
              producto: widget.producto,
              sucursal: widget.sucursal,
              existencias: snapshot.data,
            );
          case ConnectionState.active:
            return Container();
          default:
            return Container();
        }
      }
    );
  }
}