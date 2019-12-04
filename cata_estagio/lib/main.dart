import 'package:cata_estagio/Login.dart';
import 'package:cata_estagio/listaValidados.dart';
import 'listaVagas.dart';
import 'detalheVaga.dart';
import 'Vagas.dart';
import 'ListaValidacao.dart';
import 'Alunos.dart';
import 'InicialCentral.dart';
import 'detalheAlunoT.dart';
import 'detalheAlunoF.dart';
import 'atualizarAluno.dart';
import 'Central.dart';
import 'InicialAluno.dart';
import 'PerfilAluno.dart';
import 'package:flutter/material.dart';
import 'detalheVagaCandidatar.dart';
import 'listaVagasAlunos.dart';
import 'confirmarCadidatura.dart';
import 'atualizarVaga.dart';

void main()
{
  var app = CataApp();
  runApp(app);
}

class CataApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    var routes ={
        '/' : (context) => Login(),
        '/Vagas' : (context) => Vagas(),
        '/Alunos' : (context) => Alunos(),
        '/Central' : (context) => Central(),
        '/Validacao' : (context) => ListaValidacao(),
        '/listaVagas' : (context) => ListaVagas(),
        '/listaVagasAlunos' : (context) => ListaVagasAlunos(),
        '/detalheVaga' : (context) => DetalheVaga(),
        '/detalheVagaCandidatar' : (context) => DetalheVagaCandidatar(),
        '/atualizarAluno' : (context) => AtualizarAlunos(),
        '/atualizarVaga' : (context) => AtualizarVagas(),
        '/detalheAluno' : (context) => DetalheAlunoT(),
        '/detalheAlunoF' : (context) => DetalheAlunoF(),
        '/InicialAluno' : (context) => InicialAluno(),
        '/perfilAluno' : (context) => PerfilAluno(),
        '/Validados' : (context) => ListaValidados(),
        '/confirmarCandidatura' : (context) => ConfirmarCandidatura(),
        //'/ViewPDFPage' : (context) => ViewPDFPage(),
        // '/detalheValidacao' : (context) => ValidarAluno(), 
        '/InicialCentral' : (context) => InicialCentral(),
    };

    var materialApp = MaterialApp(routes: routes, initialRoute: '/');
    



    return materialApp;
  }
}

