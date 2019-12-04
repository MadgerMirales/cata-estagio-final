import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';


class AtualizarAlunos extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => CadastroState();
}

class CadastroState extends State<AtualizarAlunos>
{

  var formKey = GlobalKey<FormState>();

  String email, senha, ra, curso;
  String id;
  bool status;

    void initState(){
    super.initState();

    

    this.email='';
    this.senha='';
    this.curso='';
    this.ra='';

    _userToData();  
  }





  Future <void> _userToData() async {
    var user = await FirebaseAuth.instance.currentUser();
    Firestore.instance.collection('Alunos').document(user.uid).get().then((documento){
      setState(() {
        this.id = user.uid;
        this.curso = documento.data['Curso']; 
        this.ra = documento.data['RA'];  
        //this.status = documento.data['status'];
      });
    });
  }



  

  @override
  Widget build(BuildContext context) {



  
  
    var titulo = Center(child: Text("Atualizar Aluno",));
    var appBar = AppBar(title: titulo, backgroundColor: Colors.red,);


    /*var txtEmail = TextFormField(
      decoration: InputDecoration(
        labelText: "email: "+email, border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white,width: 50)),
        hintText: email,
      ),
      onSaved: (value) => email = value,
    );

    var txtSenha = TextFormField(
      decoration: InputDecoration(
        labelText: "senha: "+senha, border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white,width: 50)),
        hintText: senha,
      ),
      onSaved: (value) => senha = value,
    );*/

    var txtCurso = TextFormField(
      decoration: InputDecoration(
        labelText: "Curso: ", border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white,width: 50)),
        hintText: curso,
      ),
      onSaved: (value) => curso = value,
    );

    var txtRa = TextFormField(
      decoration: InputDecoration(
        labelText: "RA: ", border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white,width: 50)),
        hintText: ra,
      ),
      onSaved: (value) => ra = value,
    );

    

    /*var switchbotao = Switch(value: status, 
    onChanged: (bool value){
    value = true;
    });*/
    var textoAtualizar = Text("Atualizar",  
    style: TextStyle(color: Colors.white));
    
    

    var botaoAtualizar = RaisedButton(
      child: textoAtualizar, 
      onPressed: (){
        formKey.currentState.save();
        if(curso=="ADS"||curso=="Info"||curso=="Agro")
        {
          //formKey.currentState.save();
          Firestore.instance.collection('Alunos').document(id).updateData({

            "Curso": curso,
            "RA" : ra,
         });
      
          Navigator.of(context).pushNamed('/perfilAluno');
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
        

        
      },
      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
      color: Colors.red);

      var textoVoltar = Text("Voltar", 
      style: TextStyle(color: Colors.white));

      var botaoVoltar = RaisedButton(
      child: textoVoltar,
      onPressed: (){
        Navigator.of(context).pushNamed('/perfilAluno');
      }, 
      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
      color: Colors.red
    );

    var rowBtn = Row(children: [botaoVoltar, botaoAtualizar,], 
                mainAxisAlignment: MainAxisAlignment.spaceBetween, );


    var containerBotao = Container(
    margin: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0), 
    child: rowBtn,  
     );

    /*var containerEmail = Container(
    margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0), 
    child: txtEmail,  
    );

    var containerSenha = Container(
    margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0), 
    child: txtSenha,  
    );*/

    var containerCurso = Container(
    margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0), 
    child: txtCurso,  
    );

    var containerRa = Container(
    margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0), 
    child: txtRa,  
    );

    /*var containerSwitch = Container(margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0),
    child: switchbotao,
    );*/

    var coluna = Column(children: [containerCurso,containerRa,
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