import 'package:cata_estagio/ViewPDFPage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:async';


  


class DetalheAlunoT extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => DetalheState();
}

class DetalheState extends State<DetalheAlunoT>
{
  var formKey = GlobalKey<FormState>();
  String id;
  String email = '';
  String senha = '';
  String curso = '';
  String ra = '';
  bool status;
  
  
  @override
  Widget build(BuildContext context) {

    Future.delayed(Duration.zero,() {
        this.id = ModalRoute.of(context).settings.arguments;

        Firestore.instance
          .collection('Alunos')
          .document(this.id).get().then((documento) {

            setState(() {
              this.email = documento.data['email'];
              this.senha = documento.data['senha'];
              this.curso = documento.data['Curso']; 
              this.ra = documento.data['RA']; 
              this.status = documento.data['status'];
            });
          });
    });

        void savenow() async{
          await Firestore.instance.collection('Aunos').document(id).updateData({
            "status" : true
          });
          
        }

    
    

    

    


    var textoTitulo = Text("Detalhe do Aluno");
    var appBar = AppBar(title: textoTitulo, backgroundColor: Colors.red,);

    // Body (Scaffold):

    var estilo = TextStyle(color: Colors.blue[900], fontSize: 18.0, );
    var estilo2 = TextStyle(color: Colors.white, fontSize: 18.0, );

    
    var aluno = Center(child: Text('email: '+this.email, style: estilo,));

    var containerEmail = Container(
    margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0), 
    child: aluno,  
    );

    var senha = Center(child: Text('senha: '+this.senha, style: estilo,));

    var containerSenha = Container(
    margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0), 
    child: senha,  
    );

    var curso = Center(child: Text('Curso: '+this.curso, style: estilo));
  
    var containerCurso = Container(
    margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0), 
    child: curso,  
    );

    var ra = Center(child: Text('RA: '+this.ra, style: estilo));
  
    var containerRA = Container(
    margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0), 
    child: ra,  
    );

    
    var txtval = Center(child: Text('Validar', style: estilo2));

    var txtEdit = Center(child: Text('Editar', style: estilo));
    var txtDel = Center(child: Text('Deletar', style: estilo2));

    /*var btnEdit = RaisedButton(
      child: txtEdit,
      onPressed: (){
        Navigator.of(context).pushNamed('/atualizarAluno', arguments: this.id);
      }
    );*/

    var btnVal = RaisedButton(
      child: txtval,
      onPressed: () async {
        this.status = true;
        //formKey.currentState.save();
        //await savenow();
        await Firestore.instance.collection('Alunos').document(id).updateData({
            "status" : status
        });
        Navigator.of(context).pushNamed('/Validacao');
        
        
      },
      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
      color: Colors.red);


    /*var containerEdit = Container(
    margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0), 
    child: btnEdit,  
    );*/

    var containerVal = Container(
      margin:  EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0),
      child: btnVal,
    );

    var btnDel = RaisedButton(
      child: txtDel,
      onPressed: (){
        Firestore.instance.collection('Alunos').document(id).delete();
        
        Navigator.of(context).pushNamed('/InicialCentral');
      },
      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
      color: Colors.red
    );
      

    var containerDel = Container(
    margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0), 
    child: btnDel,  
    );

    var rowBtn = Row(children: [containerDel, containerVal], 
                mainAxisAlignment: MainAxisAlignment.spaceBetween, );

    var containerRow = Container(
    margin: EdgeInsets.fromLTRB(10.0, 3.0, 10.0, 3.0), 
    child: rowBtn,  
    );

    var coluna = Column(children: [containerEmail, containerSenha,containerCurso, containerRA, containerRow],
     crossAxisAlignment: CrossAxisAlignment.center );

    var scaffold = Scaffold(body: coluna, appBar: appBar,);

    return scaffold;
  }

  
  
}


