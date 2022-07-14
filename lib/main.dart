import 'package:flutter/material.dart';
import 'package:calculator/constants.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const Calculator());
}

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var userInput = '';
  var result = '';
  void buttonPressed(String text) {
    setState(() {
      userInput += text;
    });
  }

  Widget getRow(
    String charButton1,
    String charButton2,
    String charButton3,
    String charButton4,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // ‌buttton column 1
        TextButton(
          style: TextButton.styleFrom(
              primary: blueColor,
              minimumSize: Size(77, 77),
              maximumSize: Size(77, 77),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              side: BorderSide(width: 0, color: Colors.transparent),
              backgroundColor: setColor(charButton1)),
          onPressed: () {
            if (charButton1 == 'ac') {
              setState(() {
                userInput = '';
                result = '';
              });
            } else {
              buttonPressed(charButton1);
            }
          },
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              charButton1,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: whiteColor,
                fontSize: 32,
              ),
            ),
          ),
        ),

        // ‌buttton column 2
        TextButton(
          style: TextButton.styleFrom(
              primary: blueColor,
              minimumSize: Size(77, 77),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              side: BorderSide(width: 0, color: Colors.transparent),
              backgroundColor: setColor(charButton2)),
          onPressed: () {
            if (charButton2 == 'ce') {
              setState(() {
                if (userInput.length > 0) {
                  userInput = userInput.substring(0, userInput.length - 1);
                }
              });
            } else {
              buttonPressed(charButton2);
            }
          },
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              charButton2,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: whiteColor,
                fontSize: 32,
              ),
            ),
          ),
        ),

        // ‌buttton column 3
        TextButton(
          style: TextButton.styleFrom(
              primary: blueColor,
              minimumSize: Size(77, 77),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              side: BorderSide(width: 0, color: Colors.transparent),
              backgroundColor: setColor(charButton3)),
          onPressed: () => buttonPressed(charButton3),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              charButton3,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: whiteColor,
                fontSize: 32,
              ),
            ),
          ),
        ),

        // ‌buttton column 4
        TextButton(
          style: TextButton.styleFrom(
              primary: blueColor,
              minimumSize: Size(77, 77),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              side: BorderSide(width: 0, color: Colors.transparent),
              backgroundColor: setColor(charButton4)),
          onPressed: () {
            if (charButton4 == '=') {
              Parser parser = Parser();
              Expression expression = parser.parse(userInput);
              ContextModel contextModel = ContextModel();
              double eval =
                  expression.evaluate(EvaluationType.REAL, contextModel);
              setState(() {
                result = eval.toString();
              });
            } else {
              buttonPressed(charButton4);
            }
          },
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              charButton4,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: whiteColor,
                fontSize: 32,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'WorkSans-R'),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: bgDarkColor,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                flex: 40,
                child: Container(
                  color: bgDarkColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(height: 16),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          userInput,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: whiteColor.withOpacity(0.7),
                              fontSize: 40,
                              fontFamily: 'WorkSans-L'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          result,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: whiteColor,
                              fontSize: 88,
                              fontFamily: 'WorkSans-L'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 65,
                child: Container(
                  color: bgDarkColor,
                  child: Column(
                    // ‌Button Names
                    children: [
                      getRow('ac', 'ce', '%', '/'),
                      SizedBox(
                        height: 20,
                      ),
                      getRow('7', '8', '9', '*'),
                      SizedBox(
                        height: 20,
                      ),
                      getRow('4', '5', '6', '-'),
                      SizedBox(
                        height: 20,
                      ),
                      getRow('1', '2', '3', '+'),
                      SizedBox(
                        height: 20,
                      ),
                      getRow('00', '0', '.', '='),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /* Set different colors to buttons Section */
  bool isItems1(String text) {
    var list1 = ['00', '0', '.', '1', '2', '3', '4', '5', '6', '7', '8', '9'];

    for (var item in list1) {
      if (text == item) {
        return true;
      }
    }
    return false;
  }

  bool isItems2(String text) {
    var list2 = ['ac', 'ce', '%'];

    for (var item in list2) {
      if (text == item) {
        return true;
      }
    }
    return false;
  }

  bool isItems3(String text) {
    var list3 = ['/', '*', '-', '+', '='];

    for (var item in list3) {
      if (text == item) {
        return true;
      }
    }
    return false;
  }

  Color? setColor(String text) {
    if (isItems1(text)) {
      return grey1Color;
    } else if (isItems2(text)) {
      return grey2Color;
    } else if (isItems3(text)) {
      return blueColor;
    }
    return null;
  }
}
