import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo/Authorization/login.dart';
import 'package:todo/Authorization/signup.dart';
import 'package:todo/global/global.dart';
import 'package:todo/list.dart';
import 'package:todo/task_modal.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  runApp(Myapp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

int count = 0;

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: signupscreen(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _task = TextEditingController();
  Widget buildbottomsheet(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Text(
              "Add New Task",
              style: TextStyle(
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 30),
            ),
            SizedBox(
              height: 50,
            ),
            TextField(
              controller: _task,
              autofocus: true,
              decoration: InputDecoration(hintText: "Add new task"),
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.indigo)),
              onPressed: () {
                if (_task.text.isEmpty) {
                  Fluttertoast.showToast(msg: "fields Cant be Empty");
                } else {
                  String newtask = _task.text;
                  bool isstate = false;
                  setState(() {
                    tasks.add(Task(name: newtask, isdone: isstate));
                    count = tasks.length;
                  });

                  DatabaseReference userssref =
                      FirebaseDatabase.instance.ref().child("users");
                  userssref
                      .child(currentFirebaseUser!.uid)
                      .child("taskdetails");
                  DatabaseReference userTasksRef = userssref
                      .child(currentFirebaseUser!.uid)
                      .child("taskdetails");

                  List<Map<String, dynamic>> tasksData = tasks
                      .map((task) => {
                            'name': task.name,
                            'isdone': task.isdone,
                          })
                      .toList();
                  userTasksRef.set(tasksData).then((_) {
                    print('Tasks pushed to Firebase under current user');
                  }).catchError((error) {
                    print('Error pushing tasks: $error');
                  });
                }
                Navigator.of(context).pop();
              },
              child: Text("Add"),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 111, 130, 239),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(context: context, builder: buildbottomsheet);
          },
          child: Icon(Icons.add),
          backgroundColor: const Color.fromARGB(255, 93, 107, 182),
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 60, left: 30, right: 30, bottom: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 30,
                        backgroundColor:
                            const Color.fromARGB(255, 93, 107, 182),
                        child: Icon(
                          Icons.list,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Todoey",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 60,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(count.toString() + " Tasks",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold)),
                      TextButton(
                          onPressed: () {
                            fAuth.signOut();
                            Navigator.push(context,
                                MaterialPageRoute(builder: (c) => Login()));
                          },
                          child: Text(
                            "Signout",
                            style: TextStyle(color: Colors.white),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: list(),
                  ),
                  height: 430,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                ),
              ),
            ]),
      ),
    );
  }
}
