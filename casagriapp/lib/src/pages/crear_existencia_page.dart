import 'package:flutter/material.dart';
class CrearExistenciaPage extends StatefulWidget {
  @override
  _CrearExistenciaPageState createState() => _CrearExistenciaPageState();
}

class _CrearExistenciaPageState extends State<CrearExistenciaPage> {
  int existencia=0;
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: new AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Theme.of(context).textSelectionColor
        ),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
             _crearFondo(),
            _crearFormulario(context)
          ],
        ),
      ),
    );
  }
  Widget _crearFondo(){
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.white,
    );
  }
  Widget _crearFormulario(BuildContext context){
    final size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      autovalidate: _autoValidate,
      child: Center(
        child: Container(
          width: size.width*0.80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _crearExistencia(context),
              _crearBoton(context),
            ],
          ),
        ),
      ),
    );
  }
  Widget _crearExistencia(BuildContext context){
    final size=MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        bottom: size.height*0.03
      ),
      child: TextFormField(
        style: TextStyle(
          fontSize: 14.0
        ),
        maxLines: null,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: 'Ingrese Existencia',
          hintText: 'Ej. 100',
          labelStyle: TextStyle(
            fontSize: 14.0,
            color: Theme.of(context).primaryColor,
            fontFamily: 'fredoka',
            fontWeight: FontWeight.normal
          ),
          prefixIcon: Icon(Icons.alternate_email,size: 15.0)
        ),
        onChanged: (value){
          existencia=int.parse(value);
        },
        //validator: validacionCorreo,
      ),
    );
  }

 
  Widget _crearBoton(BuildContext context){
    final size = MediaQuery.of(context).size;
    return MaterialButton(
      color: Theme.of(context).primaryColor,
      height: size.height*0.05,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Agregar Existencia',style: TextStyle(color:Colors.white, fontSize: size.height*0.02 ,fontFamily: 'quicksand',fontWeight: FontWeight.bold)),
        ],
      ),
      onPressed: (){

      },
    );
  }
}