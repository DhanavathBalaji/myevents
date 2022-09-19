import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'events.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Signup extends StatelessWidget {
  Signup({Key? key}) : super(key: key);
  late String name,email,password;
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignUp '),
        backgroundColor:Colors.deepPurpleAccent
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30,),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20 ),
              child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your Name',

                  ),
                  onChanged: (value) {
                    name=value;
                  }
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20 ),
              child: TextField(

                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your Email',
                  ),
                  onChanged: (value) {
                    email=value;
                    print(email);
                  }
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20 ),
              child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                  onChanged: (value) {
                    password=value;
                  },
              ),

            ),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: () async {

              try {
                UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: "$email",
                    password: "$password",
                );
                print('1');
                db.collection("users").doc(email).set({"name": name});
                print('2');
                Navigator.pushReplacementNamed(context, 'home',arguments: email);
              } on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password') {
                  print('The password provided is too weak.');
                } else if (e.code == 'email-already-in-use') {
                  print('The account already exists for that email.');
                }
                else
                  {
                    print('registered');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  TableEventsExample()),
                    );
                  }
              } catch (e) {
                print(e);
              }
            },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
              ),
                child: Text("sign up",

                  style: TextStyle(

                      fontWeight: FontWeight.w600,
                      fontSize:18,
                       ),
                  ),


                ),


          ],
        ),
      ),
    );
  }
}
