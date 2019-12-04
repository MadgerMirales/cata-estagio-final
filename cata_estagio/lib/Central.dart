import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Central extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => CadastroState();
}

class CadastroState extends State<Central>
{

  var formKey = GlobalKey<FormState>();

  String email, senha;
  bool status = true;
  bool adm = true;

  void _cadastrar() async {
    var result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email,password: senha);

        // cadastra na coleção
    await Firestore.instance.collection('Alunos').document(result.user.uid).setData(
          {
          "email": email,
          "senha": senha,
          "status": status,
          "adm": adm
        });
        Navigator.of(context).pop();
  }


  @override
  Widget build(BuildContext context)
  {
    var titulo = Center(child: Text("Cadastro de Professor"),);
    var appBar = AppBar(title: titulo, backgroundColor: Colors.red,);


    var txtEmail = TextFormField(
      decoration: InputDecoration(
        labelText: "E-mail:", border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white,width: 50)),
        hintText: "",
      ),
      onSaved: (value) => email = value,
    );

    var txtSenha = TextFormField(
      decoration: InputDecoration(
        labelText: "Senha: minimo 6 caracteres", border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white,width: 50)),
        hintText: "",
      ),
      onSaved: (value) => senha = value,
    );

    
   

    var textoSalvar = Text("Salvar",  
    style: TextStyle(color: Colors.white));

    var botaoSalvar = RaisedButton(
      child: textoSalvar, 
      onPressed: (){
        formKey.currentState.save();
        // Cadastra usuario no Firebase
        _cadastrar();
      },
      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
      color: Colors.red);

      var textoVoltar = Text("Voltar", 
      style: TextStyle(color: Colors.white));

      var botaoVoltar = RaisedButton(
      child: textoVoltar,
      onPressed: (){
        Navigator.of(context).pushNamed('/inicialCentral');
      }, 
      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
      color: Colors.red
    );

    var rowBtn = Row(children: [botaoVoltar, botaoSalvar,], 
                mainAxisAlignment: MainAxisAlignment.spaceBetween, );


    var containerBotao = Container(
    margin: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0), 
    child: rowBtn,  
     );

    var containerEmail = Container(
    margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0), 
    child: txtEmail,  
    );

    var containerSenha = Container(
    margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0), 
    child: txtSenha,  
    );

   

    var coluna = Column(children: [containerEmail, containerSenha,
                  containerBotao ],
                    crossAxisAlignment: CrossAxisAlignment.center );
    
    var containerColuna = Container(
    margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
    child: coluna,  
    );


    var form = Form (key: formKey,child: containerColuna,);
    

    var lista = ListView(
      children: [form],
    );

    var scaffold = Scaffold(body: lista, appBar: appBar,);

    return scaffold;


  }

  
}