import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class InicialAluno extends StatefulWidget
{
  @override 
  State<StatefulWidget> createState() => InicialState();
}

class InicialState extends State<InicialAluno>
{
  FirebaseMessaging _messaging = FirebaseMessaging();
  @override
    void initState(){
      super.initState();
      _messaging.configure(
          onMessage: (Map<String, dynamic> message){
             print("on message $message");
             showDialog(
               context: context,
               builder: (context) => AlertDialog(
                    content: ListTile(
                        title: Text(message['notification']['title']),
                        subtitle: Text(message['notification']['body']),
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child:  Text('OK'),
                        onPressed: () => Navigator.of(context).pop(),
                      )
                    ],
                  ),
             );
          /* final snackbar = SnackBar(
            content: Text(message['notificaton']['title']),
            action: SnackBarAction(
              label: 'Go',
              onPressed: () => null,
            ),
          );
            Scaffold.of(context).showSnackBar(snackbar); */
            
          },
          onResume: (Map<String, dynamic> message){
              print("on resume $message");
          },

          onLaunch: (Map<String, dynamic> message){
              print("on lauch $message");
         },
      );
    }


  @override
  Widget build(BuildContext context) {
    var pessoa;

    var titulo = Center(child: Text("Aluno"));
    var appBar = AppBar(title: titulo, backgroundColor: Colors.red,);

    var txtListar = Text("   Lista de Vagas   ", 
    style: TextStyle(color: Colors.white));

    var btnListar = RaisedButton(
      child: txtListar,
      onPressed: (){
        Navigator.of(context).pushNamed('/listaVagasAlunos');
      }, 
      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
      color: Colors.red
    );


    var txtAlunos = Text("Meu Perfil", 
    style: TextStyle(color: Colors.white));

    var btnAlunos = RaisedButton(
      child: txtAlunos,
      onPressed: (){
        Navigator.of(context).pushNamed('/perfilAluno');
      }, 
      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
      color: Colors.red
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

    var coluna = Column(children: [label, containerListar, btnAlunos],
                    crossAxisAlignment: CrossAxisAlignment.center );


    var containerColuna = Container(
    margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0), 
    child: coluna,  
     );

    var scaffold = Scaffold(body: containerColuna, appBar: appBar,);

    return scaffold;
  }

}