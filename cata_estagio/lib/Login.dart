import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

abstract class BaseAuth{
  Future<String> signWithEmailAndPassword(String email, String senha);
}
class Auth implements BaseAuth
{
  Future<String> signWithEmailAndPassword(String email, String senha) async
  {
    AuthResult user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password:senha);
    return user.user.uid;
  }
}



class Login extends StatefulWidget
{
  Login({this.auth});
  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => LoginState();  
}

class LoginState extends State<Login>
{
  var formKey = GlobalKey<FormState>();

  String email, senha, info, id;

  bool adm;
  bool invisible = true;

  void inContact(TapDownDetails details){
    setState(() {
     invisible = false; 
    });
  }

  void outContact(TapUpDetails details){
    setState(() {
     invisible = true; 
    });
  }


  

  bool validateAndSave(){
    final form = formKey.currentState;
      if(form.validate()){
       form.save();
       return true;
    }
    return false;
  }

  void validateAndSubmit() async{
  if(validateAndSave()){
    try{
      AuthResult  result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: senha);
      var doc = await Firestore.instance.collection('Alunos').document(result.user.uid).get();

      //FirebaseAuth.instance.currentUser();
      print("Signerd in: ${result.user.uid} ");
      if(doc.data['adm']==true){
        if( doc.data['status']==true){
          Navigator.of(context).pushReplacementNamed('/InicialCentral');
        }
        else{
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: new Text("Erro!!"),
                content: new Text("Conta não validada"),
                actions: <Widget>[
                  new FlatButton(
                    child: new Text("Fechar"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ],
              );
            },
          );
        }
      }
      else{
        if( doc.data['status']==true){
          Navigator.of(context).pushReplacementNamed('/InicialAluno');
        }
        else{
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: new Text("Erro!!"),
                content: new Text("Conta não validada"),
                actions: <Widget>[
                  new FlatButton(
                    child: new Text("Fechar"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ],
              );
            },
          );
        }
      }
      
    }
    catch (e){
         showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Erro!!"),
            content: new Text("Login ou senha invalidos"),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Fechar"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
    
}


  @override
  Widget build(BuildContext context) {
    
    var gd = GestureDetector(
        onTapDown: inContact,
        onTapUp: outContact,
        child: Icon(Icons.remove_red_eye,)
      
      

    );
    
    /*var info = Text(
          "Informe seu Login e senha ou Crie sua conta",
            style: new TextStyle(fontSize:20.0,
            color: Colors.white,
            fontFamily: "Roboto"),
    );*/

    /*var info = TextFormField(
      decoration: InputDecoration(
        labelText: "Informe seu Login e senha ou Crie sua conta",border: OutlineInputBorder(),
      ),
    );*/
    var info = Center(child: Text("Informe seu Login e senha ou Crie sua conta"),);
    

    var containerInfo = Container(
    margin: EdgeInsets.fromLTRB(10.0, 70.0, 10.0, 60.0), 
    child: info,  
     );

    var txtEmail = TextFormField(
      decoration: InputDecoration(
        labelText: "E-mail",border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 50)),
        hintText: "Digite o E-mail"
      ),
      onSaved: (value) {
        email = value;
      },
    );

    var containerEmail = Container(
    margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0), 
    child: txtEmail,  
     );

    var txtSenha = TextFormField(
      decoration: InputDecoration(
        labelText: "Senha",border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 50)),
        suffixIcon: gd
      ),
      keyboardType: TextInputType.emailAddress,
      obscureText: invisible,
      onSaved: (value) => senha = value,
    );

    var containerSenha = Container(
    margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0), 
    child: txtSenha,  
     );
    
    var txtLogar = Text("Logar", 
    style: TextStyle(color: Colors.white));

    var btnLogar = RaisedButton(
      child: txtLogar,
      onPressed: validateAndSubmit,
    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
    color: Colors.red);     
    

    var containerSalvar = Container(
    margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0), 
    child: btnLogar,  
     );


    var txtCadastrar = Text("Não Cadastrado",
    style: TextStyle(color: Colors.white));

    var btnCadastrar = RaisedButton(
    child: txtCadastrar,
    onPressed: () {
       Navigator.of(context).pushNamed('/Alunos');

      // Firestore.instance
      //   .collection('contatos')
      //   .add({
      //     "nome": nome,
      //     "email" : email,
      //     "telefone" : telefone
      //   });
    },
    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
    color: Colors.red);

    var containerCadastrar = Container(
    margin: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 30.0), 
    child: btnCadastrar,  
     );
    






    // var linhaBotao = Row(children:[containerSalvar,],mainAxisAlignment: MainAxisAlignment.spaceEvenly);
    var coluna = Column(children: [containerInfo, containerEmail, containerSenha, btnLogar, btnCadastrar],crossAxisAlignment: CrossAxisAlignment.center);
    var lista = ListView(
      children: [
        coluna,
      ]
    );

    var form = Form(key: formKey, child: lista);

    return Scaffold(
      body: form,
    );
  }
}

