import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ListaValidacao extends StatelessWidget
{
  bool status = false;

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
          .collection('Alunos').where("status", isEqualTo: status)
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
            return ItemContato(doc["email"], doc["RA"], doc.documentID,);
            
            
          },
        );
      },
    );

    var appBar = AppBar(
      title: Text("Alunos a serem validados"), backgroundColor: Colors.red,
    );

    return Scaffold(
      appBar: appBar,
      body: lista,
      //floatingActionButton: fab,
    );
  }
}

class ItemContato extends StatelessWidget
{
  final String email;
  final String ra;
  final String id;
  
  ItemContato(this.email, this.ra, this.id);

  @override
  Widget build(BuildContext context) {
    
    
    var coluna;
    if(ra!=null){
      coluna = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(this.email),
        Text(this.ra,
          style: TextStyle(
            color: Colors.grey[700]
          )
        )
      ],
    );
    }
    


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
        .pushNamed('/detalheAluno', arguments: this.id)
    );
    
    return gd;
  }

}