import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';


class ListaVagas extends StatelessWidget
{
  



  @override
  Widget build(BuildContext context) {

    // var lista = ListView(
    //   children: [
    //     ItemContato("Tony Stark", "tony@marvel.com"),
    //     ItemContato("Steve Rogers", "steve@marvel.com"),
    //   ]
    // );
    

    var lista = StreamBuilder(
      stream: Firestore.instance
          .collection('Vagas')
          // .orderBy("nome", descending: true)
          // .where("nome", isGreaterThanOrEqualTo: "Tony")
          .snapshots(),
      builder: (context, snapshots) {

        if(!snapshots.hasData)
          return Center(
            child: CircularProgressIndicator()
          );

        return ListView.builder(
          itemCount: snapshots.data.documents.length,
          itemBuilder: (context, index) {
            var doc = snapshots.data.documents[index];
            return ItemContato(doc["empresa"], doc["vaga"],doc.documentID);
          },
        );
      },
    );

    var appBar = AppBar(
      title: Center(child: Text("Vagas Cadastradas")), backgroundColor: Colors.red,
    );

    /*var fab = FloatingActionButton(
      tooltip: "Adicionar Contato",
      child: Icon(Icons.add),
      onPressed: () {
        Navigator.of(context).pushNamed('/cadastro');
      },
    );*/

    return Scaffold(
      appBar: appBar,
      body: lista,
      //floatingActionButton: fab,
    );
  }
}

class ItemContato extends StatelessWidget
{
  final String empresa;
  final String vaga;
  final String id;

  var formKey = GlobalKey<FormState>();

  String cursoUser;
  @override
  Future <void> _userToData() async {
    var user = await FirebaseAuth.instance.currentUser();
    Firestore.instance.collection('Alunos').document(user.uid).get().then((documento){
      
        this.cursoUser = documento.data['Curso']; 
      
    });
  }

  ItemContato(this.empresa, this.vaga, this.id);
  String curso;
  

  @override
  Widget build(BuildContext context) {

    

    //var imagem = Image.asset('imagens/fatec.jpeg',);

    
    var coluna;
    //if(cursoUser == curso)
    coluna = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(this.empresa),
        Text(this.vaga,
          style: TextStyle(
            color: Colors.grey[700]
          )
        )
      ],
    );

    

    var containerColuna = Container(
      margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0 ),
      child: coluna,
    );
    
    var row = Row(
      children: [
        //Container(width: 3.0,),
        containerColuna
      ],
    );

    

    var txtEmpresa = Text("Logar", 
    style: TextStyle(color: Colors.white));

    var btnEmpresa = RaisedButton(
      child: txtEmpresa,
      onPressed: () {
        formKey.currentState.save();

        // Firestore.instance
        //   .collection('contatos')
        //   .add({
        //     "nome": nome,
        //     "email" : email,
        //     "telefone" : telefone
        //   });

        Navigator.of(context).pushNamed('/Inicial');
      },
    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
    color: Colors.deepPurple);


    var container = Container(
      margin: EdgeInsets.fromLTRB(6.0, 8.0, 6.0, 0.0),
      child: row,
      color: Colors.transparent,
    );

    var lista = ListView(
      children: [containerColuna],
    );


    var gd = GestureDetector(
      child: container,
      onTap: () => Navigator.of(context)
        .pushNamed('/detalheVaga', arguments: this.id)
    );
    

    return gd;
  }
}