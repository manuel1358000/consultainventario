import 'package:casagriapp/src/models/producto_model.dart';
import 'package:casagriapp/src/models/sucursal_model.dart';
import 'package:casagriapp/src/pages/listado_existencias_page.dart';
import 'package:casagriapp/src/providers/producto_provider.dart';
import 'package:casagriapp/src/utils/existencia_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class ProductoWidget extends StatefulWidget {
  final Function siguienteBusqueda;
  final List<ProductoModel> productos;
  final SucursalModel sucursal;
  ProductoWidget({@required this.siguienteBusqueda,@required this.productos,@required this.sucursal});
  
  @override
  _ProductoWidgetState createState() => _ProductoWidgetState();
}
class _ProductoWidgetState extends State<ProductoWidget> {
  final _pageController=new PageController(
    initialPage: 0,
    viewportFraction: 0.13
  );
  ProductoModel productoModel;
  ProductoProvider productosProvider = new ProductoProvider();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    _pageController.addListener((){
      if(_pageController.position.pixels>_pageController.position.maxScrollExtent-100&&_pageController.position.pixels<_pageController.position.maxScrollExtent-90){
        widget.siguienteBusqueda();
      }
    });
    return Container(
      height: size.height,
      width: size.width*0.85,
      color: Colors.transparent,
      child: ListView.builder(
        controller: _pageController,
        itemCount: widget.productos.length,
        itemBuilder: (context,i){
          productoModel=widget.productos[i];
          return _crearProductos(context, widget.productos[i]);
        },
        scrollDirection: Axis.vertical,
      ),
    );
  }
  Widget _crearProductos(BuildContext context, ProductoModel producto){
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
      child: _crearInfo(context,producto),
    );
  }
  Widget _crearInfo(BuildContext context,ProductoModel producto){
    return Column(
      children: <Widget>[
        _crearNombre(context),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _crearCodigo(context),
            _crearUnidadMedida(context)
          ],
        ),
        _crearExistencia(context),
        _crearBotones(context,producto)
      ],
    );
  }
  Widget _crearExistencia(BuildContext context){
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
      future:productosProvider.sumaExistencia(productoModel.idProducto,widget.sucursal.idSucursal),
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
            productoModel.existencia=snapshot.data['totalproductos']==null?0:int.parse(snapshot.data['totalproductos'].toString());
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
  
  Widget _crearNombre(BuildContext context){
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(
        left: size.width*0.04,
        right: size.width*0.04,
        top: size.width*0.03
      ),
      child: Text(productoModel.nombre,textAlign: TextAlign.center,style: TextStyle(fontSize: size.height*0.025,color:Theme.of(context).textSelectionColor,fontFamily: 'fredoka',fontWeight: FontWeight.bold)),
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
          child: Text(productoModel.unidadMedida,textAlign: TextAlign.center,style: TextStyle(fontSize: size.height*0.025,color:Theme.of(context).primaryColor,fontFamily: 'fredoka',fontWeight: FontWeight.normal)),
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
          child: Text(productoModel.codigoGenerado,textAlign: TextAlign.center,style: TextStyle(fontSize: size.height*0.025,color:Theme.of(context).primaryColor,fontFamily: 'fredoka',fontWeight: FontWeight.normal)),
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
  Widget _crearBotones(BuildContext context,ProductoModel producto){
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height*0.10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _crearListadoExistencia(context,producto),
          _crearAgregarExistencia(context,producto)
        ],
      ),
    );
  }
  Widget _crearListadoExistencia(BuildContext context,ProductoModel producto){
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).primaryColor
      ),
      child: IconButton(
        icon: Icon(FontAwesomeIcons.solidEye,color: Colors.white),
        onPressed: (){
          Navigator.push(context,new MaterialPageRoute(builder: (context)=>new ListadoExistenciasPage(sucursal: widget.sucursal,producto: producto)));
        }
      ),
    );
  }
  Widget _crearAgregarExistencia(BuildContext context,ProductoModel producto){
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue
      ),
      child: IconButton(
        icon: Icon(FontAwesomeIcons.plus,color: Colors.white),
        onPressed: (){
          crearExistencia(context,producto,widget.sucursal);
        }
      ),
    ); 
  }
}