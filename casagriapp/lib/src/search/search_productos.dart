import 'package:casagriapp/src/bloc/producto_bloc.dart';
import 'package:casagriapp/src/models/producto_model.dart';
import 'package:casagriapp/src/models/sucursal_model.dart';
import 'package:casagriapp/src/providers/producto_provider.dart';
import 'package:casagriapp/src/widgets/producto_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class SearchProductos extends SearchDelegate{
  ProductoProvider productosProvider = new ProductoProvider();
  ProductoBloc productoBloc = new ProductoBloc();
  SucursalModel sucursal;
  SearchProductos({@required this.sucursal});
  @override
  String get searchFieldLabel=>'Ingrese codigo producto';
  final _pageController=new PageController(
    initialPage: 0,
    viewportFraction: 0.20
  );
  @override
  List<Widget> buildActions(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return [
      IconButton(
        icon: Icon(FontAwesomeIcons.times,size: size.height*0.03),
        onPressed: (){
          query='';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return IconButton(
      icon: Icon(FontAwesomeIcons.chevronLeft,size: size.height*0.03),
      onPressed: (){
        close(context,null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // crea los resultados que se muestran los productos
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _crearBusqueda(context,query);
  }
  Widget _crearBusqueda(BuildContext context,String query){
    final size = MediaQuery.of(context).size;
    return FutureBuilder(
      future:productosProvider.buscarProductos(query),
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
            return Center(child:CircularProgressIndicator());
          case ConnectionState.active:
            return Container();
          case ConnectionState.done:
           if(snapshot.data.length==0){
              return Container();
            }
            return Container(
              width: size.width,
              child: ProductoWidget(
                sucursal: sucursal,
                productos: snapshot.data,
                siguienteBusqueda: productosProvider.buscarProductos
              ),
            ); 
          default:
            return Container();
        }
      }
    );
  }
}