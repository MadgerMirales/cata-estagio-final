import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Vagas extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => CadastroState();
}



class CadastroState extends State<Vagas>
{

  var formKey = GlobalKey<FormState>();

  String empresa, vaga, email, descricao;
  bool curso1 = false, curso2 = false, curso3 = false;

  var cursos = [];

  bool status = false;
  

  @override
  Widget build(BuildContext context)
  {


    var titulo = Center(child: Text("Cadastro de Vaga"));
    var appBar = AppBar(title: titulo, backgroundColor: Colors.red,);

    

    // var imagem = Image.asset('imagens/fatec.jpeg',);

    //var estiloEmpresa = TextStyle(fontSize: 18.0);
    var txtEmpresa = TextFormField(
      decoration: InputDecoration(
        labelText: "Empresa:", border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white,width: 50)),
        hintText: "",
      ),
      onSaved: (value){
        empresa = value;
      },
    );

    
    var txtVaga = TextFormField(
      decoration: InputDecoration(
        labelStyle: TextStyle(fontSize: 18.0 ), border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white,width: 50)),
        labelText: "Vaga:",
        hintStyle: TextStyle(fontSize: 18.0 ),
        hintText: "",
      ),
      onSaved: (value) => vaga = value,
    );

    var switchButton1 = [Switch(value: status,
                              onChanged: (bool value){
                                curso1 = value;
                              },),Text('ADS'),
                              Switch(value: status,
                              onChanged: (bool value){
                                curso2 = value;
                              },),Text('Agro'),
                              
                              Switch(value: status,
                              onChanged: (bool value){
                                curso3 = value;
                              },),Text('Info')];

     var rowCusos = Row(children: switchButton1, 
                mainAxisAlignment: MainAxisAlignment.spaceBetween, );
      
        
        
      

    var txtEmail = TextFormField(
      decoration: InputDecoration(
        labelText: "E-mail:", border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white,width: 50)),
        hintText: "",
      ),
      onSaved: (value) => email = value,
    );

    var txtDesc = TextFormField(
      decoration: InputDecoration(
        labelText: "Descrição: ", border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white,width: 50)),
        hintText: "",
      ),
      onSaved: (value) => descricao = value,
    );

    /*var listaDesc = ListView(
      children: [txtDesc],
    );*/


    // var colunaEmpresa = Column(children: [txtEmpresa],);
    //var textoEmpresa = Text("RioSoft");

    ehUmEmail(String email){
      return email.contains("@") && 
          email.contains(".") &&
          email.length >= 3;
    }

    validacoes(String empresa, String vaga, String email, List cursos, String descricao) {
      var validado = false;
      if(empresa != "" &&
        vaga != "" &&
        ehUmEmail(email) &&
        cursos.length >=1 &&
        descricao != ""
        ) {
        validado = true;
      }

      return validado;
    }
    
    var textoSalvar = Text("Salvar",  
    style: TextStyle(color: Colors.white));

    var botaoSalvar = RaisedButton(
      child: textoSalvar, 
      onPressed: (){
        if(curso1)
          cursos.add("ADS");
        if(curso2)
          cursos.add("Agro");
        if(curso3)
          cursos.add("Info");

        formKey.currentState.save();

        if(validacoes(empresa, vaga, email, cursos, descricao)){
          Firestore.instance.collection('Vagas').add(
          {
            "empresa": empresa,
            "vaga": vaga,
            "email": email,
            "descricao": descricao,
            "Curso": cursos
          });
          
          Navigator.of(context).pop();
        } else {
          Fluttertoast.showToast(
            msg: "* Preemcha a empresa\n* Preemcha a vaga\n* Preemcha o email (@ e .)\n* Preemcha os cursos\n* Preemcha a descrição",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
          );
        }
        

      }, 
      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
      color: Colors.red);

    var textoVoltar = Text("Voltar", 
    style: TextStyle(color: Colors.white));

    var botaoVoltar = RaisedButton(
      child: textoVoltar,
      onPressed: (){
        Navigator.of(context).pushNamed('/InicialCentral');
      }, 
      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
      color: Colors.red
    );

    
  
    

    

    //var colum = Column(children:[imagem, txtEmpresa, txtVaga, txtEmail, txtDesc,)

    /*var estiloVaga = TextStyle(fontSize: 18.0);
    var vaga = ;

    var estiloEmail = TextStyle(fontSize: 18.0);
 

    var estiloDesc = TextStyle(fontSize: 18.0);
    */
   
    /*var containerCorSalvar = Container(
    color: Colors.deepPurple[200],
    child: botaoSalvar,
    );

    var containerCorVoltar = Container(
    color: Colors.deepPurple[200],
    child: botaoVoltar,
    )*/

    var rowBtn = Row(children: [botaoVoltar, botaoSalvar,], 
                mainAxisAlignment: MainAxisAlignment.spaceBetween, );



    var containerBotao = Container(
    margin: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0), 
    child: rowBtn,  
     );

    /*var containerImagem = Container(
    margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0), 
    child: imagem,  
     );*/

    var containerEmpresa = Container(
    margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0), 
    child: txtEmpresa,  
    );

    var containerVaga = Container(
    margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0), 
    child: txtVaga,  
    );

    var containerEmail = Container(
    margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0), 
    child: txtEmail,  
    );
    
    var containerDesc = Container(
    margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0), 
    child: txtDesc,  
    );


     var coluna = Column(children: [ containerEmpresa, 
                  containerVaga, containerEmail, rowCusos,containerDesc,
                  containerBotao ],
                    crossAxisAlignment: CrossAxisAlignment.center );




    var containerColuna = Container(
    margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
    child: coluna,  
    );

    /*var listaVaga = ListView(
      children: [containerColuna],
    );*/


    

    var form = Form (key: formKey,child: containerColuna,);
    

    var lista = ListView(
      children: [form],
    );

    var scaffold = Scaffold(body: lista, appBar: appBar,);

    
    

    return scaffold;
  }

  
}
