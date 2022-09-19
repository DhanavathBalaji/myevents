import 'package:flutter/material.dart';
import 'loading.dart';
import 'Todo.dart';
import 'events.dart';
import 'signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    initialRoute: 'welcome',
    routes: {
      'welcome': (context) => MyApp(),
      'home': (context) => TableEventsExample(),
      'signup': (context) => Signup(),
      'home/todo': (context) => TodoF(),
      'todoL': (context)=> Todo(),
    },
    // home: MyApp(),
       // home: TableEventsExample(),
       ),
  );
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // fire();

    return Scaffold(
      appBar: AppBar(

        title: Text(
          'Welcome to events app',
        ),
        centerTitle: true,
      ),
        body: Column(

          children: [


      Container(
        height:MediaQuery.of(context).size.height/2,
        decoration: BoxDecoration(
          image: DecorationImage(
            image:AssetImage("images/home.png",),
          ),
        ),
      ),
           // SizedBox(height: 200,),
            Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  Signup()),
                  );
                },style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
              ),

                child:Text('SignUp',
                    style: TextStyle(
                     // fontFamily: 'Pacifico',
                      fontWeight: FontWeight.w600,
                      fontSize:18,
                      color: Colors.white,
                       ),
                       ),
              ),

            ),
            SizedBox(height: 20,),
            Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  Login()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
                ),
                child:Text('Login',
                    style: TextStyle(
                     // fontFamily: 'Pacifico',
                      fontWeight: FontWeight.w600,
                      fontSize:18,
                      color: Colors.white,
                       ),
                       ),
              ),
            ),
          ],
        ),
    );
  }
}


