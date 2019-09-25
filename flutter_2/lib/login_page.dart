//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'auth.dart';
// import 'home_page.dart';
// import 'package:flutter_2/login_page.dart';

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       home: new LoginPage(),
//       theme: new ThemeData(
//         primarySwatch: Colors.blue
//       )
     

      
//     );
//   }
// }

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title, this.auth, this.onSignedIn}) : super(key: key);final BaseAuth auth;
  final VoidCallback onSignedIn;
  final String title;
  @override
  State createState()=> new LoginPageState();
  
   
    
    
  }

enum FormType{
  login,register
}


class LoginPageState extends State<LoginPage> {

      final formKey= new GlobalKey<FormState>();
      String _password;
      String _email;
      FormType _formType= FormType.login;
      String _authHint = '';


  bool validateandSave(){
     final form= formKey.currentState;
     if(form.validate()){
       print("form is valid");
       form.save();
       return true;
     }
     else{
       print("form invalid");
       return false;
     }
  }

  void validateAndSubmit() async {
    if (validateandSave()) {
      try {
        String userId = _formType == FormType.login
            ? await widget.auth.signIn(_email, _password)
            : await widget.auth.createUser(_email, _password);
        setState(() {
          _authHint = 'Signed In\n\nUser id: $userId';
          print(_authHint);
        });
        widget.onSignedIn();
      }
      catch (e) {
        setState(() {
          _authHint = 'Sign In Error\n\n${e.toString()}';
        });
        print(e);
      }
    } else {
      setState(() {
        _authHint = '';
      });
    }
  }


  void movetoRegister(){
    
    setState(() {
      _formType= FormType.register;
      _authHint='';
    });
    
  }
  
    void movetoLogin(){
    setState(() {
      _formType= FormType.login;
      _authHint='';
    });
    
  }
  @override
  Widget build(BuildContext context){

                return new Scaffold(
                  backgroundColor: Colors.black,
                  body:new Stack(
                    fit:StackFit.expand,
                    children: <Widget>[
                      new Image(
                        image: new AssetImage("assets/loginpage.jpeg"),
                        fit: BoxFit.cover,
                        color: Colors.black87,
                        colorBlendMode: BlendMode.darken,
            
                        ),
            
                      new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new FlutterLogo(
            
                            
            
                        ),
                        new Form(
                          key: formKey,
                          child: new Theme(
                            data: new ThemeData(
                              brightness: Brightness.dark,
                              primarySwatch: Colors.teal,
                              inputDecorationTheme: new InputDecorationTheme(
                                labelStyle: new TextStyle(
                                  color: Colors.teal, fontSize: 20
                                )
                              )
                            ),
                            
                            child: Container(
                                padding: const EdgeInsets.all(40),
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                                children:  buildInputs() + buildSubmitButtons(),
                              
                              
                                

                      // new Padding(
                      //   padding: const EdgeInsets.only(top:40.0),
                      // ),
                      // new MaterialButton(
                      //   height: 50,
                      //   minWidth:200.0,
                      //   color: Colors.teal,
                      //   textColor: Colors.white,
                      //   child: new Text("Login"),
                      //   onPressed: validateandSubmit,
                        
                      //   splashColor: Colors.redAccent,

                      // ),

                      // new Padding(
                      //   padding: const EdgeInsets.only(top:40.0),
                      // ),
                      // new MaterialButton(
                      //   height: 50,
                      //   minWidth:200.0,
                      //   color: Colors.teal,
                      //   textColor: Colors.white,
                      //   child: new Text("Signup"),
                      //   splashColor: Colors.redAccent,
                      //   onPressed:movetoRegister,
                       

                      // ),


                   
                ),
                 ),
              )

              ),
            ],
            )
        ],
      ),
    );
  }

  List<Widget> buildInputs(){
    return [
        new TextFormField(
          key: new Key('email'),
                                    decoration: new InputDecoration(
                                      labelText: "Enter Email",
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) => value.isEmpty ? "Email can\t be empty" :null,
                                    onSaved: (value) => _email=value,
                          ),
    
                          new TextFormField(
                            key: new Key('password'),
                            decoration: new InputDecoration(
                              labelText: "Enter Password",
                            ),
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            validator: (value) => value.isEmpty ? "Password can\t be empty" :null,
                            onSaved: (value) => _password=value,
                      ),
    ];



  }

  List<Widget> buildSubmitButtons(){

    if (_formType== FormType.login){
      print("inn");
    return [
       new Padding(
                        padding: const EdgeInsets.only(top:20.0),
                      ),
                      new MaterialButton(
                        key: new Key('login'),
                        height: 50,
                        minWidth:200.0,
                        color: Colors.teal,
                        textColor: Colors.white,
                        child: new Text("Login"),
                        onPressed: validateAndSubmit,
                        
                        splashColor: Colors.redAccent,

                      ),

                      new Padding(
                        padding: const EdgeInsets.only(top:20.0),
                      ),
                      new MaterialButton(
                        key: new Key('register'),
                        height: 50,
                        minWidth:200.0,
                        color: Colors.teal,
                        textColor: Colors.white,
                        child: new Text("Signup"),
                        splashColor: Colors.redAccent,
                        onPressed:movetoRegister,
                       

                      ),
    ];
    }
    else{
          return [
                      new Padding(
                        padding: const EdgeInsets.only(top:20.0),
                      ),

                         new MaterialButton(
                           key: new Key('register'),
                        height: 50,
                        minWidth:200.0,
                        color: Colors.teal,
                        textColor: Colors.white,
                        child: new Text("Signup333"),
                        splashColor: Colors.redAccent,
                        onPressed:validateAndSubmit,
                       

                      ),

                       new Padding(
                        padding: const EdgeInsets.only(top:20.0),
                      ),
                   
                      new MaterialButton(
                        key: new Key('login'),
                        height: 50,
                        minWidth:200.0,
                        color: Colors.teal,
                        textColor: Colors.white,
                        child: new Text("Login333"),
                        onPressed: movetoLogin,
                        
                        splashColor: Colors.redAccent,

                      ),

                     
          ];
    }
  }



  
}








