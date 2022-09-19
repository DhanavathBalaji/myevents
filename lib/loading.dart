import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Pair.dart';
class Todo extends StatefulWidget {
  const Todo({Key? key}) : super(key: key);

  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  late String user;
  List<Pair> L=[];
  late Map<String,dynamic> data;


  Future<void> fire  () async
  {
    print("fire");
    await FirebaseFirestore.instance.collection("users").doc(user).get().then(
          (DocumentSnapshot doc) {
        data = doc.data() as Map<String, dynamic>;
        // ...
      },
      onError: (e) => print("Error getting document: $e"),

    );
      data["event"]?.forEach((key, value) {
        List<dynamic> x=value;
        x.forEach((element) {
          L.add(Pair(element,key));
        });
      });
      Navigator.pushReplacementNamed(context, 'home/todo',arguments: L);

    // data["event"]?.forEach((key, value) {
    //   List<dynamic> x=value;
    //   x.forEach((element) {
    //     L.add(Pair(element,key));
    //   });
    // });


    print(L[0].first);
  }
  @override
  Widget build(BuildContext context) {
    user = ModalRoute.of(context)?.settings.arguments as String;
    fire();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'To Do list',
        ),
        centerTitle: true,

      ),
      body: Text("Loading"),


    );
  }
}



