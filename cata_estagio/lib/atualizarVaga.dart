import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';


class AtualizarVagas extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => AtualizarState();
}

class AtualizarState extends State<AtualizarVagas>
{
  var formKey = GlobalKey<FormState>();

  String empresa, vaga, email, descricao, id;
  bool curso1 = false, curso2 = false, curso3 = false;

  var cursos = [];

  bool status = false;

  
  @override
  Widget build(BuildContext context) {

    Future.delayed(Duration.zero,() {
        this.id = ModalRoute.of(context).settings.arguments;

        Firestore.instance
          .collection('Vagas')
          .document(this.id).get().then((documento) {

            setState(() {
              this.empresa = documento.data['empresa'];
              this.vaga = documento.data['vaga'];
              this.email = documento.data['email'];
              this.cursos = documento.data['Curso'];
              this.descricao = documento.data['descricao']; 
            });
          });
    });
    var titulo = Center(child: Text("Cadastro de Vaga"));
    var appBar = AppBar(title: titulo, backgroundColor: Colors.red,);

    var txtEmpresa = TextFormField(
      decoration: InputDecoration(
        labelText: "Empresa:", border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white,width: 50)),
        hintText: "",
      ),
      onSaved: (value){
        empresa = value;
      },
    );

    
    var txtVaga = TextFormField(
      decoration: InputDecoration(
        labelStyle: TextStyle(fontSize: 18.0 ), border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white,width: 50)),
        labelText: "Vaga:",
        hintStyle: TextStyle(fontSize: 18.0 ),
        hintText: "",
      ),
      onSaved: (value) => vaga = value,
    );

    var switchButton1 = [Switch(value: status,
                              onChanged: (bool value){
                                curso1 = value;
                              },),Text('ADS'),
                              Switch(value: status,
                              onChanged: (bool value){
                                curso2 = value;
                              },),Text('Agro'),
                              
                              Switch(value: status,
                              onChanged: (bool value){
                                curso3 = value;
                              },),Text('Info')];

     var rowCusos = Row(children: switchButton1, 
                mainAxisAlignment: MainAxisAlignment.spaceBetween, );
      
        
        
      

    var txtEmail = TextFormField(
      decoration: InputDecoration(
        labelText: "E-mail:", border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white,width: 50)),
        hintText: "",
      ),
      onSaved: (value) => email = value,
    );

    var txtDesc = TextFormField(
      decoration: InputDecoration(
        labelText: "Descrição: ", border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white,width: 50)),
        hintText: "",
      ),
      onSaved: (value) => descricao = value,
    );

    ehUmEmail(String email){
      return email.contains("@") && 
          email.contains(".") &&
          email.length >= 3;
    }

    validacoes(String empresa, String vaga, String email, List cursos, String descricao) {
      var validado = false;
      if(empresa != "" &&
        vaga != "" &&
        ehUmEmail(email) &&
        cursos.length >=1 &&
        descricao != ""
        ) {
        validado = true;
      }

      return validado;
    }

    var textoSalvar = Text("Salvar",  
    style: TextStyle(color: Colors.white));

    var botaoSalvar = RaisedButton(
      child: textoSalvar, 
      onPressed: (){
        if(curso1)
          cursos.add("ADS");
        if(curso2)
          cursos.add("Agro");
        if(curso3)
          cursos.add("Info");

        //formKey.currentState.save();

        if(validacoes(empresa, vaga, email, cursos, descricao)){
          Firestore.instance.collection('Vagas').document(id).updateData(
          {
            "empresa": empresa,
            "vaga": vaga,
            "email": email,
            "descricao": descricao,
            "Curso": cursos
          });
          
          Navigator.of(context).pop();
        } else {
          Fluttertoast.showToast(
            msg: "* Preemcha a empresa\n* Preemcha a vaga\n* Preemcha o email (@ e .)\n* Preemcha os cursos\n* Preemcha a descrição",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
          );
        }
        

      }, 
      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
      color: Colors.red);

    var textoVoltar = Text("Cancelar", 
    style: TextStyle(color: Colors.white));

    var botaoVoltar = RaisedButton(
      child: textoVoltar,
      onPressed: (){
        Navigator.of(context).pushNamed('/listaVagas');
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

    var containerEmpresa = Container(
    margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0), 
    child: txtEmpresa,  
    );

    var containerVaga = Container(
    margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0), 
    child: txtVaga,  
    );

    var containerEmail = Container(
    margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0), 
    child: txtEmail,  
    );
    
    var containerDesc = Container(
    margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0), 
    child: txtDesc,  
    );


     var coluna = Column(children: [ containerEmpresa, 
                  containerVaga, containerEmail, rowCusos,containerDesc,
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