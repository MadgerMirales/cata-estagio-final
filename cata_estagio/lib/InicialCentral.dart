import 'package:flutter/material.dart';

class InicialCentral extends StatefulWidget
{
  @override 
  State<StatefulWidget> createState() => InicialState();
}

class InicialState extends State<InicialCentral>
{
  @override
  Widget build(BuildContext context) {

    var titulo = Center(child: Text("Central"));
    var appBar = AppBar(title: titulo, backgroundColor: Colors.red,);
    //var aluno = Center(child: Text('email: '+this.email, style: estilo,));

    var txtListar = Text("   Vagas    ", 
    style: TextStyle(color: Colors.white));

    var btnListar = RaisedButton(
      child: txtListar,
      onPressed: (){
        Navigator.of(context).pushNamed('/listaVagas');
      }, 
      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
      color: Colors.red
    );

    var txtCadastrar = Text("cadastrar", 
    style: TextStyle(color: Colors.white));

    var btnCadastrar = RaisedButton(
      child: txtCadastrar,
      onPressed: (){
        Navigator.of(context).pushNamed('/Central');
      }, 
      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
      color: Colors.red
    );

    var txtAlunos = Text("Validar Alunos", 
    style: TextStyle(color: Colors.white));

    var btnValidacao = RaisedButton(
      child: txtAlunos,
      onPressed: (){
        Navigator.of(context).pushNamed('/Validacao');
      }, 
      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
      color: Colors.red
    );

    var txtAlunosValidados = Text("Alunos Validados", 
    style: TextStyle(color: Colors.white));

    var btnValidado = RaisedButton(
      child: txtAlunosValidados,
      onPressed: (){
        Navigator.of(context).pushNamed('/Validados');
      }, 
      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
      color: Colors.red
    );

    var txtVagas = Text("Cadastrar Vaga", 
    style: TextStyle(color: Colors.white));

    var btnVaga = RaisedButton(
      child: txtVagas,
      onPressed: (){
        Navigator.of(context).pushNamed('/Vagas');
      }, 
      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
      color: Colors.red
    );
    var containerVaga = Container(
    margin: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0), 
    child: btnVaga,  
    );
    

    var containerCadastrar = Container(
    margin: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0), 
    child: btnCadastrar,  
    );

    var containerValidar = Container(
    margin: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0), 
    child: btnValidacao,  
    );

    var containerValidado = Container(
    margin: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0), 
    child: btnValidado,  
    );


    var containerListar = Container(
    margin: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0), 
    child: btnListar,  
    );

    var estilo = TextStyle(color: Colors.black, fontSize: 18.0, );
    var lblOla = Center(child: Text("Olá, \nSeja Bem Vindo", style: estilo,));
    /*var lblOla = TextFormField(
      decoration: InputDecoration(
        labelText: "Olá, \nSeja Bem Vindo",
      ),
    );*/

    var label = Container(
    margin: EdgeInsets.fromLTRB(30.0, 150.0, 30.0, 50.0), 
    child: lblOla,  
    );

    var coluna = Column(children: [label, containerCadastrar, containerListar, containerValidar, containerValidado, containerVaga],
                    crossAxisAlignment: CrossAxisAlignment.center );


    var containerColuna = Container(
    margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0), 
    child: coluna,  
     );

    var scaffold = Scaffold(body: containerColuna, appBar: appBar,);

    return scaffold;
  }

}