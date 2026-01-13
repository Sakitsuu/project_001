import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project_001/application.dart';
import 'package:project_001/barcode_scanner.dart';
import 'package:project_001/firebase_options.dart';
import 'package:project_001/register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => print("Firebase Initialized"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Screen',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Login Screen'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String username = '';
  String password = '';
  bool isPasswordVisible = true;

  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //create collection
    // db.collection("Collection_test").doc("init").set({});
    //delet collection
    // db.collection("Collection_test").doc("init").delete();

    //add colection
    db.collection("Collection_credentials").doc().set({});

    //add data to collection
    db.collection("Collection_credentials").add({
      "username": "user",
      "password": "user",
    });

    db.collection("Collection_credentials").add({
      "username": "admin",
      "password": "admin",
    });

    //read data from collection
    db.collection("Collection_credentials").get().then((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        print(doc.data());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 300,
              child: TextField(
                decoration: InputDecoration(labelText: 'Username'),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (isPasswordVisible) {
                        setState(() {
                          isPasswordVisible = false;
                        });
                      } else {
                        setState(() {
                          isPasswordVisible = true;
                        });
                      }
                    },
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                ),
                obscureText: isPasswordVisible,
              ),
            ),
            SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ApplicationPage(title: 'Application Screen'),
                  ),
                );
              },
              child: Text('Login'),
            ),
            SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ApplicationPage(title: 'Register Screen'),
                  ),
                );
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
