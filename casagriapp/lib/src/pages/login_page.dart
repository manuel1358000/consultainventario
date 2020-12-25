import 'package:casagriapp/src/models/usuario_model.dart';
import 'package:casagriapp/src/providers/usuario_provider.dart';
import 'package:casagriapp/src/utils/data.dart';
import 'package:casagriapp/src/utils/mensaje_widget.dart';
import 'package:casagriapp/src/utils/validacion.dart';
import 'package:flutter/material.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  Data data;
  bool visibilidad=true;
  bool _autoValidate=false;
  UsuarioProvider usuarioProvider=new UsuarioProvider();
  final _formKey = GlobalKey<FormState>();
  //UsuarioModel usuarioModel=new UsuarioModel();
  UsuarioModel usuarioModel=new UsuarioModel();
  String validacion="";

  @override
  void initState() { 
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      try{
        mostrarAlerta(context, data.contenido);
      }catch(e){
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    data=ModalRoute.of(context).settings.arguments;
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
            _crearFondo(context),
            _crearFormulario(context)
          ],
        ),
      ) 
    );
  }
  Widget _crearFondo(BuildContext context){
    final size = MediaQuery.of(context).size;
    return Container(
      color: Theme.of(context).backgroundColor,
      height: double.infinity,
      width: double.infinity
    );
  }
  Widget _crearFormulario(BuildContext context){
    final size=MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      autovalidate: _autoValidate,
      child: Center(
        child: Container(
          width: size.width*0.80,
          alignment: Alignment.center,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _crearTexto(context),
                _crearUsuario(context),
                _crearContra(context),
                _crearBotonLogin(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _crearTexto(BuildContext context){
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width*0.70,
      margin: EdgeInsets.only(
        bottom: size.width*0.05
      ),
      alignment: Alignment.center,
      child: Text('CASAGRI, S.A.',style: TextStyle(fontSize: size.height*0.045,color:Theme.of(context).textSelectionColor,fontFamily: 'fredoka',fontWeight: FontWeight.bold)),
    );
  }
  
  Widget _crearUsuario(BuildContext context){
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
          labelText: 'Usuario',
          hintText: 'Ej. Usuario',
          labelStyle: TextStyle(
            fontSize: 14.0,
            color: Theme.of(context).primaryColor,
            fontFamily: 'fredoka',
            fontWeight: FontWeight.normal
          ),
          prefixIcon: Icon(Icons.alternate_email,size: 15.0)
        ),
        onChanged: (value){
          usuarioModel.usuario=value;
        },
        validator: validacionUsuario,
      ),
    );
  }
  Widget _crearContra(BuildContext context){
    final size=MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        bottom: size.width*0.03
      ),
      child: TextFormField(
        style: TextStyle(
          fontSize: 14.0
        ),
        obscureText: visibilidad,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: 'Contraseña',
          labelStyle: TextStyle(
            fontSize: 14.0,
            color: Theme.of(context).primaryColor,
            fontFamily: 'fredoka',
            fontWeight: FontWeight.normal
          ),
          prefixIcon: Icon(Icons.lock_outline,size: 17.0),
          suffixIcon: IconButton(
            onPressed: (){
              setState(() {
                visibilidad=!visibilidad;
              });
            },
            icon: Icon(
              visibilidad==true?Icons.visibility:Icons.visibility_off,
              size: 17.0
            )
          ),
        ),
        onChanged: (value){
          usuarioModel.contra=value;
        },
        validator: validacionPassword,
      ),
    );
  }
  
  Widget _crearBotonLogin(BuildContext context){
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        top: size.height*0.02
      ),
      child: MaterialButton(
        color: Theme.of(context).primaryColor,
        height: size.height*0.06,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Iniciar Sesion',style: TextStyle(color:Colors.white, fontSize: size.height*0.025 ,fontFamily: 'fredoka',fontWeight: FontWeight.normal)),
            ],
          ),
        ),
        onPressed: usuarioModel!=null ? (){
          if(_formKey.currentState.validate()){
            _iniciarSesion(usuarioModel,context);
          }
          setState(() {
            _autoValidate=true;          
          });
        }:null,
      ),
    );
  }
  _iniciarSesion(UsuarioModel usuarioForm,BuildContext context)async{
    Map result= await usuarioProvider.login(usuarioForm.usuario,usuarioForm.contra);
    if(!result['estado']){
      mostrarAlerta(context, result['mensaje']);
      return null;
    } 
    final Data data = new Data(contenido:result['mensaje']);
    Navigator.pop(context);
    Navigator.pushNamed(context,'inicio');
  } 
}