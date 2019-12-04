import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';



  


class PerfilAluno extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => PerfilState();
}

class PerfilState extends State<PerfilAluno>
{
  
  String id;
  String email = '';
  String senha = '';
  String curso = '';
  String ra = '';
  String curriculo;
  PerfilAluno fViewController;
  String assetPDFPath = '';
  String urlPDFPath = '';
  var path;
  
@override

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
        //this.id = documento.data['Id'];
        this.email = documento.data['email'];
        this.senha = documento.data['senha'];
        this.curso = documento.data['Curso']; 
        this.ra = documento.data['RA'];  
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    
    var textoTitulo = Center(child: Text("Meu Perfil"),);
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

    

    /*var btnPDF = RaisedButton(
      child: Center(child: Text('Ver PDF')),
      onPressed: (){
        
          //Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewPDFPage(path:assetPDFPath)));
        if(urlPDFPath != null)
        {
          Navigator.push(context,
          MaterialPageRoute(builder: (context) => PdfViewPage(path: assetPDFPath)));
        }
      }
      
    );

    var containerPdf = Container(
      margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0),
      child: btnPDF,
    );
    SizedBox(
      height: 20,
    );
    */

    

    /*var containerImagem = Container(
    margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0), 
    child: imagem,  
    );*/

    var txtEdit = Center(child: Text('Editar', style: estilo2));
    

    var btnEdit = RaisedButton(
      child: txtEdit,
      onPressed: (){
        Navigator.of(context).pushNamed('/atualizarAluno');
      },
      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
      color: Colors.red
    );


    var containerEdit = Container(
    margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0), 
    child: btnEdit,  
    );

    

    var rowBtn = Row(children: [containerEdit,], 
                mainAxisAlignment: MainAxisAlignment.center, );

    

    var coluna = Column(children: [containerEmail, containerSenha, containerCurso, containerRA,  rowBtn],
     crossAxisAlignment: CrossAxisAlignment.center );

    var scaffold = Scaffold(body: coluna, appBar: appBar,);

    return scaffold;
  }

  
  
}

/*class PdfViewPage extends StatefulWidget {
  final String path;

  const PdfViewPage({Key key, this.path}) : super(key: key);
  @override
  PdfViewPageState createState() => PdfViewPageState();
}

class PdfViewPageState extends State<PdfViewPage> {
  int _totalPages = 0;
  int _currentPage = 0;
  bool pdfReady = false;
  PDFViewController _pdfViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Document"),
      ),
      body: Stack(
        children: <Widget>[
          PDFView(
            filePath: widget.path,
            autoSpacing: true,
            enableSwipe: true,
            pageSnap: true,
            swipeHorizontal: true,
            nightMode: false,
            onError: (e) {
              print(e);
            },
            onRender: (_pages) {
              setState(() {
                _totalPages = _pages;
                pdfReady = true;
              });
            },
            onViewCreated: (PDFViewController vc) {
              _pdfViewController = vc;
            },
            onPageChanged: (int page, int total) {
              setState(() {});
            },
            onPageError: (page, e) {},
          ),
          !pdfReady
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Offstage()
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          _currentPage > 0
              ? FloatingActionButton.extended(
                  backgroundColor: Colors.red,
                  label: Text("Go to ${_currentPage - 1}"),
                  onPressed: () {
                    _currentPage -= 1;
                    _pdfViewController.setPage(_currentPage);
                  },
                )
              : Offstage(),
          _currentPage+1 < _totalPages
              ? FloatingActionButton.extended(
                  backgroundColor: Colors.green,
                  label: Text("Go to ${_currentPage + 1}"),
                  onPressed: () {
                    _currentPage += 1;
                    _pdfViewController.setPage(_currentPage);
                  },
                )
              : Offstage(),
        ],
      ),
    );
  }  
}*/