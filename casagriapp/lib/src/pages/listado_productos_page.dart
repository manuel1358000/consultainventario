import 'package:casagriapp/src/bloc/producto_bloc.dart';
import 'package:casagriapp/src/models/producto_model.dart';
import 'package:casagriapp/src/models/sucursal_model.dart';
import 'package:casagriapp/src/pages/listado_existencias_page.dart';
import 'package:casagriapp/src/providers/producto_provider.dart';
import 'package:casagriapp/src/search/search_productos.dart';
import 'package:casagriapp/src/utils/mensaje_widget.dart';
import 'package:casagriapp/src/widgets/producto_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:barcode_scan/barcode_scan.dart';
class ListadoProductosPage extends StatefulWidget {
  SucursalModel sucursal;
  ListadoProductosPage({this.sucursal});
  @override
  _ListadoProductosPageState createState() => _ListadoProductosPageState();
}

class _ListadoProductosPageState extends State<ListadoProductosPage> {
  ProductoProvider productoProvider = new ProductoProvider();
  ProductoBloc productoBloc = new ProductoBloc();
  @override
  Widget build(BuildContext context) {
    productoProvider.obtenerProductos();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('CASAGRI APP',style: TextStyle(fontSize: size.height*0.025,color:Theme.of(context).backgroundColor,fontFamily: 'fredoka')),
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
          _scanQR();
        },
        heroTag: 'gdsa',
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(FontAwesomeIcons.search,color: Theme.of(context).backgroundColor)
      ),
    );
  }
  _scanQR()async{
    String futureString = '';
    try{
      futureString=await BarcodeScanner.scan();
    }catch(e){
      futureString=e.toString();
    }
    if(futureString!=null){
      Map<String, dynamic>data=await productoProvider.codigoEscanner(futureString);
      if(!data['estado']){
        mostrarAlerta(context, 'No existe el codigo que escaneo, intente nuevamente');
        return null;
      }
      ProductoModel producto=data['producto'];
      Navigator.push(context,new MaterialPageRoute(builder: (context)=>new ListadoExistenciasPage(sucursal: widget.sucursal,producto: producto)));
    }
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
        _crearCajaBusqueda(context),
        _crearListadoProductos(context)
      ],
    );
  }
  Widget _crearCajaBusqueda(BuildContext context){
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.all(Radius.circular(20.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            spreadRadius: 5,
            blurRadius: 10
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
          showSearch(context: context, delegate: SearchProductos(sucursal: widget.sucursal));
        },
        child: Row(
          children: <Widget>[
            _crearIcono(context),
            _crearTexto(context)
          ],
        ),
      ),
    );
  }
  Widget _crearIcono(BuildContext context){
    return Container(
      margin: EdgeInsets.only(
        left: 20
      ),
      child: Icon(Icons.search)
    );
  }
  Widget _crearTexto(BuildContext context){
    final size = MediaQuery.of(context).size;
    return Expanded(
      flex: 1,
      child: Container(
        alignment: Alignment.center,
        height: size.height*0.05,
        child: Text('Buscar Producto',style: TextStyle(fontSize: size.height*0.025,color:Theme.of(context).textSelectionColor,fontFamily: 'fredoka',fontWeight: FontWeight.bold)),
      ),
    );
  }
  Widget _crearListadoProductos(BuildContext context){
    final size = MediaQuery.of(context).size;
    return Expanded(
      flex: 1,
      child: Container(
        width: size.width,
        color: Colors.white,
        child: _crearProductos(context),
      ),
    );
  }
  Widget _crearProductos(BuildContext context){
    return StreamBuilder(
      stream: productoBloc.productoStream,
      builder: (BuildContext context, AsyncSnapshot <List<ProductoModel>> snapshot){
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
          case ConnectionState.active:
            if(snapshot.data.length==0){
              return Container();
            }
            return ProductoWidget(
              sucursal: widget.sucursal,
              productos: snapshot.data,
              siguienteBusqueda: productoProvider.obtenerProductos
            );
          case ConnectionState.done:
            return Container();
        }
      }
    );
  }
  
}