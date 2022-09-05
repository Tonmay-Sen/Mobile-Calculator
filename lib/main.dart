import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(calculator());
}

class calculator extends StatelessWidget {
  const calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Surjo-s Calculator',
      theme: ThemeData(primarySwatch: Colors.lightBlue),
      home: surjocal(),
    );
  }
}

class surjocal extends StatefulWidget {
  const surjocal({super.key});

  @override
  State<surjocal> createState() => _surjocalState();
}

class _surjocalState extends State<surjocal> {
  String equation = "0";
  String result = "0";
  String expression = " ";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      }
      //----------------------------------
      else if (buttonText == "⌫") {
        equationFontSize = 38.0;
        resultFontSize = 48.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      }
      //--------------------------
      else if (buttonText == "=") {
        equationFontSize = 38.0;
        resultFontSize = 48.0;
        expression = equation;
        expression = expression.replaceAll("X", "*");
        expression = expression.replaceAll("÷", "/");
        expression = expression.replaceAll("—", "-");

        try {
          Parser p = new Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "0";
        }
      }
      //-----------------------
      else {
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
      //-----------------------------
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FloatingActionButton(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: const BorderSide(
                color: Color.fromARGB(199, 0, 255, 217),
                width: 0.5,
                style: BorderStyle.solid,
              )),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.normal,
                color: Colors.black),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.cyan,
          centerTitle: true,
          title: const Text('Surjo-s Calculator',
              style: TextStyle(color: Colors.black))),
      body: Column(children: <Widget>[
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: Text(
            equation,
            style: TextStyle(fontSize: equationFontSize),
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
          child: Text(
            result,
            style: TextStyle(fontSize: resultFontSize),
          ),
        ),
        const Expanded(
          child: Divider(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * .75,
              child: Table(
                children: [
                  TableRow(children: [
                    buildButton("C", 1, Color.fromARGB(176, 251, 95, 11)),
                    buildButton("⌫", 1, Color.fromARGB(255, 255, 17, 0)),
                    buildButton("÷", 1, Colors.yellowAccent),
                  ]),
                  TableRow(children: [
                    buildButton("7", 1, Colors.grey),
                    buildButton("8", 1, Colors.grey),
                    buildButton("9", 1, Colors.grey),
                  ]),
                  TableRow(children: [
                    buildButton("4", 1, Colors.grey),
                    buildButton("5", 1, Colors.grey),
                    buildButton("6", 1, Colors.grey),
                  ]),
                  TableRow(children: [
                    buildButton("4", 1, Colors.grey),
                    buildButton("5", 1, Colors.grey),
                    buildButton("6", 1, Colors.grey),
                  ]),
                  TableRow(children: [
                    buildButton("1", 1, Colors.grey),
                    buildButton("2", 1, Colors.grey),
                    buildButton("3", 1, Colors.grey),
                  ]),
                  TableRow(children: [
                    buildButton(".", 1, Colors.grey),
                    buildButton("0", 1, Colors.grey),
                    buildButton("00", 1, Colors.grey),
                  ]),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.25,
              child: Table(
                children: [
                  TableRow(children: [
                    buildButton("X", 1, Color.fromARGB(255, 20, 191, 248)),
                  ]),
                  TableRow(children: [
                    buildButton("—", 1, Color.fromARGB(255, 245, 215, 46)),
                  ]),
                  TableRow(children: [
                    buildButton("+", 2, Color.fromARGB(255, 250, 135, 12)),
                  ]),
                  TableRow(children: [
                    buildButton("=", 2, Color.fromARGB(255, 0, 255, 8)),
                  ]),
                ],
              ),
            )
          ],
        )
      ]),
    );
  }
}
