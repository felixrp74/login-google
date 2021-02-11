
import 'package:login_google/controlador/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

class RegistrarVista extends StatefulWidget {
 const RegistrarVista({Key key}) : super(key: key);

  @override
  _RegistrarVistaState createState() => _RegistrarVistaState();
}

class _RegistrarVistaState extends State<RegistrarVista> {
final GlobalKey<FormFieldState<String>> _passwordFieldKey =
      GlobalKey<FormFieldState<String>>();

  String _name="";
  String _email="";
  String _password="";
  
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  String _validateName(String value) {
    if (value.isEmpty) return 'Nambre es requerido.';
    final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
    if (!nameExp.hasMatch(value)) {
      return 'Por favor caracteres alfabeto.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (_) {
        return Scaffold(
          appBar: AppBar( title: Text('Registro')),
          body: Container(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),       
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: 24.0),
                   
                   // "name" form.
                  TextFormField(
                    controller: nameController,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      filled: true,
                      icon: Icon(Icons.person),
                      hintText: 'Como te llamaras?',
                      labelText: 'Nombre *',
                    ),
                    onSaved: (String value) {
                      this._name = value;
                      print('name=$_name');
                    },
                    validator: _validateName,
                  ),
                  const SizedBox(height: 24.0), 
                  // "Email" form.
                  TextFormField(
                    // mSecurityInputMethodService : 
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      filled: true,
                      icon: Icon(Icons.email),
                      hintText: 'tu email',
                      labelText: 'E-mail',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (String value) {
                      this._email = value;
                      print('email=$_email');
                    },
                  ), 
                  const SizedBox(height: 24.0),

                  // "Password" form.
                  // PasswordField(
                  //   // controller: passwordController,
                  //   fieldKey: _passwordFieldKey,
                  //   helperText: 'nomas que  8 caracteres.',
                  //   labelText: 'Password *',
                  //   onFieldSubmitted: (String value) {

                  //     print("por alguna ");
                  //     // this._password = value;
                  //     // // update();
                  //     //  print("----antes: $value");
                  //     // setState(() {
                  //     //   this._password = value;

                  //     //   print("----pass: $value");
                  //     // });
                  //   },
                  // ),

                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      filled: true,
                      hintText: "pass",
                      labelText: "contrasena",
                      
                    ),
                    onSaved: (String value) {
                      this._password = value;
                      print('email=$_email');
                    },

                  ),
                  const SizedBox(height: 24.0),
                   
                  // boton registrar
                  RaisedButton(
                    onPressed:  ()  {

                      print("name: ${nameController.text}");
                      print("name: ${emailController.text}");
                      print("name: ${passwordController.text}");
                      
                      if( nameController.text != "" && emailController.text != "" && 
                      passwordController.text != ""  ){
                        print("como ");

                        _.usuario.value.name = nameController.text;
                        _.usuario.value.email = emailController.text;
                        _.usuario.value.password = passwordController.text;
                        
                        _.registrar(); 

                      
                      }else {
                        print("snackbar");
                        Get.snackbar(
                          "error", "en campos / existe usuario",
                          colorText: Colors.white,
                          backgroundColor: Colors.black54,
                          barBlur: 20,
                        );
                      }

                    }, 
                    // color: Colors.purple,
                    child: Text("Registrarse", style: TextStyle(color: Colors.white70)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                  ),
                
                ]
              )
            ),
          ),
        );

      }
    );
  }
}


class PasswordField extends StatefulWidget {
  const PasswordField({
    this.fieldKey,
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
  });

  final Key fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.fieldKey,
      obscureText: _obscureText,
      maxLength: 8,
      onSaved: widget.onSaved,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        filled: true,
        hintText: widget.hintText,
        labelText: widget.labelText,
        helperText: widget.helperText,
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
        ),
      ),
    );
  }
}