import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

/*
class ViewPDFPage extends StatefulWidget
{
  final String path;

  const ViewPDFPage({Key key, this.path}) : super(key: key);
  @override
  State<StatefulWidget> createState() => ViewState();
}

class ViewState extends State<ViewPDFPage>
{
  PDFViewController pdfViewController;
  String assetPDFPath = '';
  String urlPDFPath = '';
  var path;
  bool pdfReady = false;
  int totalpagina = 0;
  int paginaAtual = 0;
  String id;
  String curriculo;

  

  


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("PDF"))
        ),
        body: Center(
          child: Builder(
            builder: (context) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  color: Colors.amber,
                  child: Text("Exibir por URL"),
                  onPressed: () {
                    if (urlPDFPath != null) {
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ViewPDFPage(path: assetPDFPath)));
                    }
                  },
                ),
                SizedBox(
                      height: 20,
                ),
                RaisedButton(
                  color: Colors.red,
                  child: Center(child: Text('Exibir por Asset'),),
                  onPressed: (){
                    if(assetPDFPath != null){
                      Navigator.push(context, 
                      MaterialPageRoute(builder: (context) => PdfViewPage(path: assetPDFPath,)));
                    }
                  },
                ),
                SizedBox(
                      height: 20,
                ),
              ],
            ),
          ),
        ),
      ), 
    );
  }
}


}
*/