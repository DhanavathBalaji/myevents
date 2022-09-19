import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Pair.dart';


class TodoF extends StatefulWidget {
  const TodoF({Key? key}) : super(key: key);

  @override
  _TodoFState createState() => _TodoFState();
}

class _TodoFState extends State<TodoF> {
  late List<Pair> L;
  @override
  Widget build(BuildContext context) {
    L = ModalRoute.of(context)?.settings.arguments as List<Pair>;
    return Scaffold(
          appBar: AppBar(
            title: Text(
              'To Do list',

            ),
            centerTitle: true,

          ),
          body: ListView.builder(
            itemCount: L.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(L[index].first),
                subtitle: Text(L[index].last),
              );
            },
          ),


        );
  }
}
