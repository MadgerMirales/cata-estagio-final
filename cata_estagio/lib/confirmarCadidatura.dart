import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';







class ConfirmarCandidatura extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => ConfirmarState();
  
}


class ConfirmarState extends State<ConfirmarCandidatura>
{
  String id;
  String idEmpresa;
  String emailEmpresa = '';
  String empresaNome = '';
  String emailUser;
  String cv= 'CV';

  get service => null;

  
  
  
  @override

  void initState(){
    super.initState();

    this.idEmpresa = id;
    this.emailUser='';
    
    _userToData();  
  }



  Future <void> _userToData() async {
    var user = await FirebaseAuth.instance.currentUser();
    Firestore.instance.collection('Alunos').document(user.uid).get().then((documento){
      setState(() {
        //this.id = documento.data['Id'];
        this.emailUser = documento.data['email'];
         
      });
    });
  }





  @override
  Widget build(BuildContext context) {
    
    Future.delayed(Duration.zero,() {
        this.idEmpresa = ModalRoute.of(context).settings.arguments;

        Firestore.instance
          .collection('Vagas')
          .document(this.idEmpresa).get().then((documento) {

            setState(() {
              this.emailEmpresa = documento.data['email'];
              this.empresaNome = documento.data['empresa'];
            });
          });
    });





    var estilo = TextStyle(color: Colors.blue[900], fontSize: 18.0);
    var textoTitulo = Center(child: Text('Envio de Email', style: estilo));
    var appBar = AppBar(title: textoTitulo);


    
    var emailUsuario = Center(child: Text('From: '+this.emailUser, style: estilo));
    var containerUser = Container(
    margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0), 
    child: emailUsuario,  
    );

    var emailEmpre = TextFormField(
      decoration: InputDecoration(
        labelText: "To: ", border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white,width: 50)),
        hintText: /*"Cara empresa "+this.empresaNome+", gostaria de poder me candidatar a vaga de estagio disponibilizada.\n"+
        "Segue abaixo o meu curriculo:"*/ "",
      )
    );
    var containerEmpresa = Container(
    margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0), 
    child: emailEmpre,  
    );

    var subject = Center(child: Text('Subject: '+this.cv, style: estilo));
    var containerSubject = Container(
    margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0), 
    child: subject,  
    );

    var txtEmail = TextFormField(
      decoration: InputDecoration(
        labelText: "Text: ", border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white,width: 50)),
        hintText: /*"Cara empresa "+this.empresaNome+", gostaria de poder me candidatar a vaga de estagio disponibilizada.\n"+
        "Segue abaixo o meu curriculo:"*/ "",
      ),
    );
    var containerTxt = Container(
    margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0), 
    child: txtEmail,  
    );

    var textoCandidatar = Text("Candidatar-se",  
    style: TextStyle(color: Colors.white));
    var botaoCandidatar = RaisedButton(
    child: textoCandidatar, 
    onPressed: ()
    {
      
    },
    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
    color: Colors.red);

    var containerCandidatar = Container(
    margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0), 
    child: botaoCandidatar,  
    );

    var coluna = Column(children: [containerUser, containerEmpresa, containerSubject, containerTxt, containerCandidatar],
     crossAxisAlignment: CrossAxisAlignment.center );

    var scaffold = Scaffold(body: coluna, appBar: appBar,);


    return scaffold;
  }
  
}