import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';



void main()
{
  // DateTime t= DateTime(2022,5,13);
  // String s=t.toString();
  // print(s+"wtf");
  // DateTime p= DateTime.parse(s);
  // s= p.toString();
  // print(s);
  // if(t==p && 5==6)  print("Yes");
  FirebaseFirestore db = FirebaseFirestore.instance;
  db.collection("event").doc()
      .get()
      .then((DocumentSnapshot file) {
    print(file.id);});

}