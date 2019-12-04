import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:image_picker/image_picker.dart';



class DetalheVagaCandidatar extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => DetalheState();
}

class DetalheState extends State<DetalheVagaCandidatar>
{

  String id;
  String empresa = '';
  String vaga = '';
  String emailPara = '';

  String descricao = '';
  String seuEmail = 'pedro.boldrin@gmail.com';
  List cursos = [];
  String attachment;

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
              this.emailPara = documento.data['email'];
              this.cursos = documento.data['Curso'];
              this.descricao = documento.data['descricao']; 
            });
          });
    });

     // AppBar
    var textoTitulo = Center(child: Text("Detalhe da Vaga"));
    var appBar = AppBar(title: textoTitulo, backgroundColor: Colors.red,);

    // Body (Scaffold):

    var estiloEmpresa = TextStyle(color: Colors.blue[900], fontSize: 18.0, );
    var empresa = Center(child: Text('Empresa: '+this.empresa, style: estiloEmpresa,));

    // 
    // var empresa = Text(this.empresa, style: estiloEmpresa);
    
    var containerEmpresa = Container(
    margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0), 
    child: empresa,  
    );
// --------------------------------------------------
    var estiloVaga = TextStyle(color: Colors.blue[900], fontSize: 18.0,);
    var vaga = Center(child: Text('Vaga: '+this.vaga, style: estiloVaga));
    


    

// -----------------------------------------------
    var containerVaga = Container(
    margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0), 
    child: vaga,  
    );

    var estiloEmail = TextStyle(color: Colors.blue[900], fontSize: 18.0);
    var email = Center(child: Text('Email: '+this.emailPara, style: estiloEmail));

    var containerEmail = Container(
    margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0), 
    child: email,  
    );

    var estiloCurso = TextStyle(color: Colors.blue[900], fontSize: 18.0);
    var curso = Center(child: Text('Curso: '+this.cursos.toString(), style: estiloCurso));

    var containerCurso = Container(
    margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0), 
    child: curso,  
    );

    var estiloDesc = TextStyle(color: Colors.blue[900], fontSize: 18.0);
    var descricao = Center(child: Text('Descricao: '+this.descricao, style: estiloDesc));

    var containerDesc = Container(
    margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0), 
    child: descricao,  
    );
    var textoCandidatar = Text("Candidatar-se",  
    style: TextStyle(color: Colors.white));

    void _openImagePicker() async {
    File pick = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      attachment = pick.path;
    });
  }

    var botaoCandidatar = RaisedButton(
    child: textoCandidatar, 
    onPressed: () async {
      //Navigator.of(context).pushNamed('/confirmarCandidatura', arguments: id);
      /*String url = 'https://us-central1-cata-estagio-410ab.cloudfunctions.net/sendMail';
      print(email.runtimeType);
      var response = await http.post(url, body:{'destinatario: ': emailPara, 'assunto: ': 'CV', 'texto' : 'teste', 'html:' : 'Hello world' });
      response.body; */
      final Email email = Email(
        body: 'Cara empresa '+this.empresa+', sou aluno da Fatec de São José do Rio Preto e gostaria de poder me candidatar para a vaga disponibilizada de '+this.vaga+
        ', agradeceria muito poder participar do processo seletivo. \nSegue abaixo o anexo do meu curriculo.',
        subject: 'CV',
        recipients: [emailPara],
        //cc: ['cc@example.com'],
        //bcc: ['bcc@example.com'],
        attachmentPath: attachment,
        isHTML: false,
      );
      await FlutterEmailSender.send(email);
    },
    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
    color: Colors.red);

    var containerCandidatar = Container(
    margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0), 
    child: botaoCandidatar,  
    );


    var coluna = Column(children: [containerEmpresa, containerVaga, containerEmail, containerCurso, containerDesc,
     containerCandidatar],
        crossAxisAlignment: CrossAxisAlignment.center );

    var scaffold = Scaffold(body: coluna, appBar: appBar,);

    return scaffold;
  }
  
}