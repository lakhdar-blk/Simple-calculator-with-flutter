import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';


void main(){

  runApp(Calculator());

}


class Calculator extends StatelessWidget{

  @override
  Widget build(BuildContext context){

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SimpleCalculator(),
    );
  }
}



class SimpleCalculator extends StatefulWidget{
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {

  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontsize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText){
      setState(() {
        if(buttonText == "C"){
          
          equation = "0";
          result = "0";

        }else if(buttonText == "←"){

          equation = equation.substring(0, equation.length  - 1);
          if(equation == ""){
            equation = "0";
          }

        }else if(buttonText == "="){
            
            expression = equation;

            try{
              
              Parser p = Parser();
              Expression exp = p.parse(expression);

              ContextModel cm = ContextModel();
              result  = '${exp.evaluate(EvaluationType.REAL, cm)}';

            }catch(e){
              result = "Invalid expression";
            }


        }else{
          if(equation == "0"){
            equation = buttonText;
          }else{
            equation = equation + buttonText;
          }
          
        }
      });
  }


  Widget BuildButton(String btnText, double buttonHeight, Color buttonColor){

    return Container(
                        height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
                        color:  buttonColor,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: buttonColor,
                              shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                              side: BorderSide(
                                color: Colors.white,
                                width: 1, 
                                style: BorderStyle.solid
                              )
                            ),
                            padding: EdgeInsets.all(16),
                            ),
                            
                            onPressed: () => buttonPressed(btnText),
                            child: Text(
                              btnText, style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.normal,
                                color: Colors.white

                              ),
                            ),
                          ),
                        );
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title:  Text('Simple Calculator')),
      body: Column(
        children: <Widget>[
          Container(
            alignment:  Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(equation, style: TextStyle(fontSize: equationFontsize),),
          ),

          Container(
            alignment:  Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(result, style: TextStyle(fontSize: resultFontSize),),
          ),

          Expanded(
            child: Divider(),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(

                width: MediaQuery.of(context).size.width * .75,
                child: Table(

                  children: [

                    TableRow(
                      children: [
                        BuildButton("C", 1, Colors.redAccent),
                        BuildButton("←", 1, Colors.blue),
                        BuildButton("/", 1, Colors.blue),
                      ]
                    ),

                    TableRow(
                      children: [
                        BuildButton("7", 1, Colors.black54),
                        BuildButton("8", 1, Colors.black54),
                        BuildButton("9", 1, Colors.black54),
                      ]
                    ),

                    TableRow(
                      children: [
                        BuildButton("4", 1, Colors.black54),
                        BuildButton("5", 1, Colors.black54),
                        BuildButton("6", 1, Colors.black54),
                      ]
                    ),

                    TableRow(
                      children: [
                        BuildButton("1", 1, Colors.black54),
                        BuildButton("2", 1, Colors.black54),
                        BuildButton("3", 1, Colors.black54),
                      ]
                    ),

                    TableRow(
                      children: [
                        BuildButton(".", 1, Colors.black54),
                        BuildButton("0", 1, Colors.black54),
                        BuildButton("00", 1, Colors.black54),
                      ]
                    ),

                  ],
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        BuildButton("*", 1, Colors.blue),
                      ]
                    ),

                    TableRow(
                      children: [
                        BuildButton("-", 1, Colors.blue),
                      ]
                    ),

                    TableRow(
                      children: [
                        BuildButton("+", 1, Colors.blue),
                      ]
                    ),

                    TableRow(
                      children: [
                        BuildButton("=", 2, Colors.redAccent),
                      ]
                    ),
                  ],
                ),
              )
            ],
          ),

        ]),
    );
  }
}