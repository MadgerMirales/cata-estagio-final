import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class DetalheVaga extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => DetalheState();
}

class DetalheState extends State<DetalheVaga>
{

  String id;
  String empresa = '';
  String vaga = '';
  String email = '';
  String descricao = '';
  List cursos = [];

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
    var email = Center(child: Text('Email: '+this.email, style: estiloEmail));

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
    
    var estilo = TextStyle(color: Colors.white, fontSize: 18.0, );
    var txtEdit = Center(child: Text('Editar', style: estilo));
    var txtDel = Center(child: Text('Deletar', style: estilo));

    var btnEdit = RaisedButton(
      child: txtEdit,
      onPressed: (){
        Navigator.of(context).pushNamed('/atualizarVaga', arguments: this.id);
      },
      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
      color: Colors.red
    );


    var containerEdit = Container(
    margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0), 
    child: btnEdit,  
    );

    var btnDel = RaisedButton(
      child: txtDel,
      onPressed: (){
        Firestore.instance.collection('Vagas').document(id).delete();
        
        Navigator.of(context).pushNamed('/listaVagas');
      },
      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
      color: Colors.red
      
    );

    var containerDel = Container(
    margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0), 
    child: btnDel,  
    );

    var rowBtn = Row(children: [containerDel, containerEdit,], 
                mainAxisAlignment: MainAxisAlignment.spaceBetween, );
    
    var containeRow = Container(
    margin: EdgeInsets.fromLTRB(10.0, 3.0, 10.0, 3.0), 
    child: rowBtn,  
    );



    var coluna = Column(children: [containerEmpresa, containerVaga, containerEmail, containerCurso, containerDesc, containeRow],
     crossAxisAlignment: CrossAxisAlignment.center );

    var scaffold = Scaffold(body: coluna, appBar: appBar,);

    return scaffold;
  }
  
}