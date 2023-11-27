import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

String textbtn = "";
double result = 0.0;

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  String userInput = "";
  String displayText = "";
  List<Map<String, dynamic>> Buttons = [
    {"texton": "C", "btncolor": Colors.grey},
    {"texton": "00", "btncolor": Colors.grey},
    {"texton": "%", "btncolor": Colors.grey},
    {"texton": "/", "btncolor": Colors.orange},
    {"texton": "7", "btncolor": Colors.grey},
    {"texton": "8", "btncolor": Colors.grey},
    {"texton": "9", "btncolor": Colors.grey},
    {"texton": "*", "btncolor": Colors.orange},
    {"texton": "4", "btncolor": Colors.grey},
    {"texton": "5", "btncolor": Colors.grey},
    {"texton": "6", "btncolor": Colors.grey},
    {"texton": "-", "btncolor": Colors.orange},
    {"texton": "1", "btncolor": Colors.grey},
    {"texton": "2", "btncolor": Colors.grey},
    {"texton": "3", "btncolor": Colors.grey},
    {"texton": "+", "btncolor": Colors.orange},
    {"texton": "0", "btncolor": Colors.grey},
    {"texton": ".", "btncolor": Colors.orange},
    {"texton": "<-", "btncolor": Colors.orange},
    {"texton": "=", "btncolor": Colors.orange},
  ];
  buttonPress(String textBtn) {
    if (textBtn == "C") {
      setState(() {
        textbtn = "";
      });
    } else if (textBtn == "<-") {
      if (textBtn.isNotEmpty) {
        setState(() {
          textbtn = textbtn.substring(0, textbtn.length - 1);
        });
      }
    } else if (textBtn == "=") {
      Parser P = Parser();
      Expression exp = P.parse(textbtn);
      ContextModel cm = ContextModel();
      setState(() {
        try {
          result = exp.evaluate(EvaluationType.REAL, cm);
          textbtn = result.toString();
        } catch (e) {
          textbtn = "Error";
        }
      });
    } else {
      setState(() {
        textbtn += textBtn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Calculator",
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: Column(children: [
        Container(
          width: double.infinity,
          height: 200,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.all(18.0),
                child: Text(textbtn,
                    style: TextStyle(color: Colors.white, fontSize: 50)),
              )
            ],
          ),
        ),
        Expanded(
          child: GridView.count(
            crossAxisCount: 4,
            children: List.generate(Buttons.length, (index) {
              return button(
                textonBtn: Buttons[index]["texton"],
                btncolor: Buttons[index]["btncolor"],
                onpress: () {
                  buttonPress(
                    Buttons[index]["texton"],
                  );
                },
              );
            }),
          ),
        )
      ]),
    );
  }
}

class button extends StatelessWidget {
  String textonBtn;
  Color btncolor;
  final onpress;
  button({required this.textonBtn, required this.btncolor, this.onpress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 28.0),
      child: GestureDetector(
        child: CircleAvatar(
          backgroundColor: btncolor,
          radius: 40,
          child: TextButton(
              onPressed: onpress,
              child: Text(
                textonBtn,
                style: TextStyle(color: Colors.black, fontSize: 28),
              )),
        ),
      ),
    );
  }
}
