import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(widget());
}

class widget extends StatefulWidget {
  const widget({super.key});

  @override
  State<widget> createState() => _widgetState();
}

class _widgetState extends State<widget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: home(),
    );
  }
}

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  String? selectedUnit1;
  String? selectedUnit2;
  double result = 0.0;
  TextEditingController _value1 = TextEditingController();

  final List<String> units = ['kilogram', 'meter', 'centimeters', 'pounds'];
  restart() {
    setState(() {
      result = 0.0;
    });
  }

  convert() {
    final numeric = num.tryParse(_value1.text);
    if (numeric == null) {
      restart();
      Fluttertoast.showToast(msg: "Enter Numeric Characters");
    } else {
      if (_value1.text.isEmpty) {
        restart();
        Fluttertoast.showToast(msg: "Fill the fields");
      }
      if (selectedUnit1 == "kilogram" && selectedUnit2 == "pounds") {
        setState(() {
          double res = double.parse(_value1.text);
          result = res * 2.205;
        });
      } else if (selectedUnit1 == "pounds" && selectedUnit2 == "kilogram") {
        setState(() {
          double res = double.parse(_value1.text);
          result = res * 0.45356237;
          print(result);
        });
      } else if (selectedUnit1 == "centimeters" && selectedUnit2 == "meter") {
        setState(() {
          double res = double.parse(_value1.text);
          result = res / 100;
        });
      } else if (selectedUnit1 == "meter" && selectedUnit2 == "centimeters") {
        setState(() {
          double res = double.parse(_value1.text);
          result = res * 100;
        });
      } else {
        restart();
        Fluttertoast.showToast(msg: "Cant Convert");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Unit Converter"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          children: [
            Expanded(
                child: Container(
              child: Column(
                children: [
                  DropdownButton<String>(
                    hint: const Text('Select a unit'),
                    value: selectedUnit1,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedUnit1 = newValue;
                      });
                    },
                    items: units.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  TextField(
                    controller: _value1,
                    decoration: InputDecoration(hintText: "Enter value"),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  DropdownButton<String>(
                    hint: const Text('Select a unit'),
                    value: selectedUnit2,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedUnit2 = newValue;
                      });
                    },
                    items: units.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )
                ],
              ),
            )),
            Expanded(
                child: Container(
              child: Column(
                children: [
                  Text(
                    "Result:",
                    style: TextStyle(color: Colors.red, fontSize: 38),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(result.toString(),
                      style: TextStyle(color: Colors.red, fontSize: 42))
                ],
              ),
            )),
            ElevatedButton(
                onPressed: () {
                  convert();
                },
                child: Text("Convert"))
          ],
        ),
      ),
    );
  }
}
