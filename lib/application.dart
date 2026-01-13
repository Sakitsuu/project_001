import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_001/barcode_scanner.dart';
import 'package:project_001/firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => print("Firebase Initialized"));
  runApp(const MyApp());
}

class ApplicationPage extends StatefulWidget {
  const ApplicationPage({super.key, required this.title});
  final String title;

  @override
  State<ApplicationPage> createState() => _ApplicationPageState();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Application Screen',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const ApplicationPage(title: 'Application Screen'),
    );
  }
}

class _ApplicationPageState extends State<ApplicationPage> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  List<Map<String, dynamic>> products = [];

  TextEditingController controller_country = TextEditingController();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    // await db.collection("Products").doc("init").set({});
    await db
        .collection("Collection_products")
        .orderBy("created_at", descending: true)
        .get()
        .then((q) {
          products.clear();
          for (var d in q.docs) {
            // print(d.id);
            // print(d.data().containsKey("bar_code"));
            // print(d.data().containsKey("name"));
            // print(d.data().containsKey("country"));
            // print(d.get("created_at"));

            var data = {
              "id": d.id,
              "bar_code": d.data().containsKey("bar_code")
                  ? d.get("bar_code")
                  : "",
              "name": d.data().containsKey("name") ? d.get("name") : "",
              "country": d.data().containsKey("country")
                  ? d.get("country")
                  : "",
              "created_at": d.get("created_at"),
            };

            // print(data);
            products.add(data);
          }
        });
    setState(() {});
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
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Register()),
                );
              },
              child: Text('Scan'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, i) {
                  return Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 160,
                        child: OutlinedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Edit Bar Code"),
                                  content: TextField(
                                    controller: TextEditingController(
                                      text: products[i]["bar_code"],
                                    ),
                                    onChanged: (value) {
                                      products[i]["bar_code"] = value;
                                    },
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Cancel"),
                                    ),
                                    Spacer(),
                                    TextButton(
                                      onPressed: () async {
                                        var id = products[i]["id"];
                                        await db
                                            .collection("Collection_products")
                                            .doc(id)
                                            .update({
                                              "bar_code":
                                                  products[i]["bar_code"],
                                            });
                                        Navigator.of(context).pop();
                                        init();
                                        setState(() {});
                                      },
                                      child: Text("Save"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text(products[i]["bar_code"]),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 160,
                        child: OutlinedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Edit Name"),
                                  content: TextField(
                                    controller: TextEditingController(
                                      text: products[i]["name"],
                                    ),
                                    onChanged: (value) {
                                      products[i]["name"] = value;
                                    },
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Cancel"),
                                    ),
                                    Spacer(),
                                    TextButton(
                                      onPressed: () async {
                                        var id = products[i]["id"];
                                        await db
                                            .collection("Collection_products")
                                            .doc(id)
                                            .update({
                                              "name": products[i]["name"],
                                            });
                                        Navigator.of(context).pop();
                                        init();
                                        setState(() {});
                                      },
                                      child: Text("Save"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text(products[i]["name"]),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 160,
                        child: OutlinedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Edit Country"),
                                  content: TextField(
                                    controller: controller_country,
                                    onChanged: (value) {
                                      products[i]["country"] = value;
                                    },
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Cancel"),
                                    ),
                                    Spacer(),
                                    TextButton(
                                      onPressed: () async {
                                        var id = products[i]["id"];
                                        await db
                                            .collection("Collection_products")
                                            .doc(id)
                                            .update({
                                              "country":
                                                  controller_country.text,
                                            });
                                        Navigator.of(context).pop();
                                        init();
                                        setState(() {});
                                      },
                                      child: Text("Save"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text(products[i]["country"]),
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () async {
                          var id = products[i]["id"];
                          print("Delete ID: $id");

                          await db
                              .collection("Collection_products")
                              .doc(id)
                              .delete();

                          init();
                          setState(() {});
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          db.collection("Collection_products").add({
            "created_at": DateTime.now(),
          });
          init();
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
