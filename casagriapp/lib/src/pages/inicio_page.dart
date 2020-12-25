import 'package:casagriapp/src/models/sucursal_model.dart';
import 'package:casagriapp/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:casagriapp/src/providers/sucursal_provider.dart';
import 'package:casagriapp/src/widgets/sucursal_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class InicioPage extends StatefulWidget {
  @override
  _InicioPageState createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  SucursalProvider sucursalProvider = new SucursalProvider();
  PreferenciasUsuario preferenciasUsuario = new PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('CASAGRI APP',style: TextStyle(fontSize: size.height*0.025,color:Theme.of(context).backgroundColor,fontFamily: 'fredoka')),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.all(size.width*0.03),
            child: IconButton(
              icon: Icon(FontAwesomeIcons.signOutAlt),
              onPressed: (){
                preferenciasUsuario.codigo=0;
                Navigator.of(context).pop();
                Navigator.pushNamed(context,'login');
              },
            )
          )
        ],
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            _crearFondo(context),
            _crearSucursales(context)
          ],     
        ),
      ),
    );
  }
  Widget _crearFondo(BuildContext context ){
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Theme.of(context).backgroundColor,
    );
  }
  Widget _crearSucursales(BuildContext context){
    return Container(
      height: double.infinity,
      child: FutureBuilder(
        future: sucursalProvider.obtenerSucursales(),
        builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>>snapshot){
        if(snapshot.hasError){
          return Center(child: CircularProgressIndicator());
        }
        switch(snapshot.connectionState){
          case ConnectionState.none:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.active:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator());
            }
            Map<String, dynamic> resp=snapshot.data;
            if(!resp['estado']){
              return Center(child: CircularProgressIndicator());
            }
            List<SucursalModel> sucursales = resp['sucursales'];
            if(sucursales.length==0){
              return Container();
            }
            return SucursalWidget(sucursales: sucursales);
        }
      },
      )
    );
  }
}