import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class Login extends StatelessWidget {
   Login({Key? key}) : super(key: key);
  late String email,password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text('sign in'),

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
                    labelText: 'email',
                  ),
                  onChanged: (value) {
                    email=value;
                    // print(email);
                  }
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
              child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                  onChanged: (value) {
                    password=value;
                  }
              ),

            ),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: () async {
              try {
                UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: "$email",
                    password: "$password"
                );
                Navigator.pushReplacementNamed(context, 'home',arguments: email);
              } on FirebaseAuthException catch (e) {
                if (e.code == 'user-not-found') {
                  print('No user found for that email.');
                } else if (e.code == 'wrong-password') {
                  print('Wrong password provided for that user.');
                }
                else{
                  print('err');
                  // Navigator.push(
                  //   context,
                    // MaterialPageRoute(builder: (context) =>  TableEventsExample()),
                  // );
                }
              }
            },style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
            ),

                child: Text("login")),

        Container(
              padding: EdgeInsets.only(top: 100),
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "images/login.png",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
