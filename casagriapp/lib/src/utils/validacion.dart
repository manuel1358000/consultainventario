
String validacionUsuario(String value){
  if(value.isEmpty) return 'Ingrese un usuario valido';
  return null;
}
String validacionPassword(String value){
  if(value.isEmpty) return 'Ingrese una contraseña valida';
  if(value.length<6) return 'Debe tener mas de 6 caracteres';
  return null;
}
String validacionConfirmacion(String value,String password){
  if(value.isEmpty) return 'Ingrese una contraseña valida';
  if(value!=password) return 'La contraseña no es igual';
  return null;
}
String validacionExistencia(String value){
  if(value.isEmpty) return 'Ingrese una existencia valida';
  return null;
}