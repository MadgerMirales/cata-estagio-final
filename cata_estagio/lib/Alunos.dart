import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Alunos extends StatefulWidget
{
  //
  @override
  State<StatefulWidget> createState() => CadastroState();
}

class CadastroState extends State<Alunos>
{

  var formKey = GlobalKey<FormState>();

  FirebaseMessaging _messaging = FirebaseMessaging();

  String email, senha, ra, curso, token;
  String curriculo = '';
  bool status = false;
  bool adm = false;

  void _cadastrar() async {
    if(curso=="ADS"||curso=="Info"||curso=="Agro"){
      var result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email,password: senha);

        await Firestore.instance.collection('Alunos').document(result.user.uid).setData(
            {
            "email": email,
            "senha": senha,
            "RA": ra,
            "Curso": curso,
            "Curriculo": curriculo,
            "status": status,
            "adm": adm
          });
        
        await _messaging.getToken().then((pega_Token){
        token = pega_Token;
        });
        await Firestore.instance.collection('Tokens').add({
            "token": token
        });
        // cadastra na coleção
        
        Navigator.of(context).pop();
    }
    else
        {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: new Text("Erro!!"),
                content: new Text("Selecione o Curso de ADS, Info ou Agro"),
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


  @override
  Widget build(BuildContext context)
  {
    var titulo = Center(child: Text("Cadastro de Aluno"));
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

    var txtRa = TextFormField(
      decoration: InputDecoration(
        labelText: "RA:", border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white,width: 50)),
        hintText: "",
      ),
      onSaved: (value) => ra = value,
    );
    var txtCurso = TextFormField(
      decoration: InputDecoration(
        labelText: "Curso: ADS, Info ou Agro", border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white,width: 50)),
        hintText: "",
      ),
      onSaved: (value) => curso = value,
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
        Navigator.of(context).pushNamed('/');
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

    var containerRa = Container(
    margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0), 
    child: txtRa,  
    );

    var containerCurso = Container(
    margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0), 
    child: txtCurso,  
    );

    var coluna = Column(children: [containerEmail, containerSenha, containerRa, containerCurso,
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