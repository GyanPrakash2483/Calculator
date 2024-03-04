import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const Calculator());
}

bool isOperator(String test) {
  if (test == '√' ||
      test == '×' ||
      test == '²' ||
      test == '/' ||
      test == '-' ||
      test == '+' ||
      test == '%') {
    return true;
  } else {
    return false;
  }
}

Future<String> evaluateOut(String expression) async {
  final response = await http.post(
    Uri.parse('https://rare-territory-production.up.railway.app/evaluate'),
    headers: {
      'Content-Type':
          'application/json' // 'application/x-www-form-urlencoded' or whatever you need
    },
    body: jsonEncode(
      {
        'expression': expression,
      },
    ),
  );

  if (response.statusCode == 200) {
    return response.body;
  } else {
    return "Error ${response.statusCode}";
  }
}

//only for testing purpose, not being used
String evaluateExpression(String expression) {
  if (expression.isEmpty) {
    return 'Empty Expression';
  }
  expression = expression.replaceAll('%', '/100*');
  expression = expression.replaceAll('π', 'pi');
  expression = expression.replaceAll('×', '*');
  expression = expression.replaceAll('√', 'sqrt');
  expression = expression.replaceAll('²', '^2');
  String result;
  try {
    result = double.parse(expression.interpret().toStringAsFixed(6)).toString();
  } catch (e) {
    result = 'Syntax Error';
  }
  return result;
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String activeIn = '';
  String passiveIn = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Calculator',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 19, 185, 250),
          centerTitle: true,
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 24, 24, 24),
                Color.fromARGB(255, 29, 29, 29),
              ],
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsetsDirectional.only(
                    start: 6, end: 6, top: 128),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color.fromARGB(255, 80, 80, 80),
                    ),
                  ),
                ),
                width: double.infinity,
                child: Text(
                  passiveIn,
                  style: const TextStyle(
                    fontSize: 42,
                    color: Colors.white,
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 20,
                    padding: const EdgeInsets.only(
                      left: 6,
                    ),
                    child: const Text(
                      '=',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 42,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    width: MediaQuery.of(context).size.width - 20,
                    padding: const EdgeInsets.only(
                      right: 6,
                    ),
                    child: Text(
                      activeIn,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 42,
                      ),
                      overflow: TextOverflow.clip,
                    ),
                  )
                ],
              ),
              Container(
                padding: const EdgeInsets.only(top: 90),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 5,
                          height: MediaQuery.of(context).size.width / 5,
                          padding: const EdgeInsets.all(2),
                          child: TextButton(
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                  Color(0xFF0B0C0F),
                                ),
                                shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                )),
                            onPressed: () => {
                              setState(() {
                                activeIn = '';
                              })
                            },
                            child: const Text(
                              'C',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 5,
                          height: MediaQuery.of(context).size.width / 5,
                          padding: const EdgeInsets.all(2),
                          child: TextButton(
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                  Color(0xFF2F2F34),
                                ),
                                shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                )),
                            onPressed: () => {
                              setState(() {
                                activeIn = '${activeIn}7';
                              })
                            },
                            child: const Text(
                              '7',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 5,
                          height: MediaQuery.of(context).size.width / 5,
                          padding: const EdgeInsets.all(2),
                          child: TextButton(
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                  Color(0xFF2F2F34),
                                ),
                                shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                )),
                            onPressed: () => {
                              setState(() {
                                activeIn = '${activeIn}4';
                              })
                            },
                            child: const Text(
                              '4',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 5,
                          height: MediaQuery.of(context).size.width / 5,
                          padding: const EdgeInsets.all(2),
                          child: TextButton(
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                  Color(0xFF2F2F34),
                                ),
                                shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                )),
                            onPressed: () => {
                              setState(() {
                                activeIn = '${activeIn}1';
                              })
                            },
                            child: const Text(
                              '1',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 5,
                          height: MediaQuery.of(context).size.width / 5,
                          padding: const EdgeInsets.all(2),
                          child: TextButton(
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                  Color(0xFF2F2F34),
                                ),
                                shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                )),
                            onPressed: () => {
                              setState(() {
                                activeIn = '${activeIn}0';
                              })
                            },
                            child: const Text(
                              '0',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 5,
                          height: MediaQuery.of(context).size.width / 5,
                          padding: const EdgeInsets.all(2),
                          child: TextButton(
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                  Color(0xFF0B0C0F),
                                ),
                                shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                )),
                            onPressed: () => {
                              setState(() {
                                activeIn = '$activeIn(';
                              })
                            },
                            child: const Text(
                              '(',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 5,
                          height: MediaQuery.of(context).size.width / 5,
                          padding: const EdgeInsets.all(2),
                          child: TextButton(
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                  Color(0xFF2F2F34),
                                ),
                                shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                )),
                            onPressed: () => {
                              setState(() {
                                activeIn = '${activeIn}8';
                              })
                            },
                            child: const Text(
                              '8',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 5,
                          height: MediaQuery.of(context).size.width / 5,
                          padding: const EdgeInsets.all(2),
                          child: TextButton(
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                  Color(0xFF2F2F34),
                                ),
                                shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                )),
                            onPressed: () => {
                              setState(() {
                                activeIn = '${activeIn}5';
                              })
                            },
                            child: const Text(
                              '5',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 5,
                          height: MediaQuery.of(context).size.width / 5,
                          padding: const EdgeInsets.all(2),
                          child: TextButton(
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                  Color(0xFF2F2F34),
                                ),
                                shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                )),
                            onPressed: () => {
                              setState(() {
                                activeIn = '${activeIn}2';
                              })
                            },
                            child: const Text(
                              '2',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 5,
                          height: MediaQuery.of(context).size.width / 5,
                          padding: const EdgeInsets.all(2),
                          child: TextButton(
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                  Color(0xFF0B0C0F),
                                ),
                                shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                )),
                            onPressed: () => {
                              setState(() {
                                if (activeIn.substring(activeIn.length - 1) ==
                                    '.') {
                                  return;
                                }
                                activeIn = '$activeIn.';
                              })
                            },
                            child: const Text(
                              '.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 5,
                          height: MediaQuery.of(context).size.width / 5,
                          padding: const EdgeInsets.all(2),
                          child: TextButton(
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                  Color(0xFF0B0C0F),
                                ),
                                shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                )),
                            onPressed: () => {
                              setState(() {
                                activeIn = '$activeIn)';
                              })
                            },
                            child: const Text(
                              ')',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 5,
                          height: MediaQuery.of(context).size.width / 5,
                          padding: const EdgeInsets.all(2),
                          child: TextButton(
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                  Color(0xFF2F2F34),
                                ),
                                shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                )),
                            onPressed: () => {
                              setState(() {
                                activeIn = '${activeIn}9';
                              })
                            },
                            child: const Text(
                              '9',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 5,
                          height: MediaQuery.of(context).size.width / 5,
                          padding: const EdgeInsets.all(2),
                          child: TextButton(
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                  Color(0xFF2F2F34),
                                ),
                                shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                )),
                            onPressed: () => {
                              setState(() {
                                activeIn = '${activeIn}6';
                              })
                            },
                            child: const Text(
                              '6',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 5,
                          height: MediaQuery.of(context).size.width / 5,
                          padding: const EdgeInsets.all(2),
                          child: TextButton(
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                  Color(0xFF2F2F34),
                                ),
                                shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                )),
                            onPressed: () => {
                              setState(() {
                                activeIn = '${activeIn}3';
                              })
                            },
                            child: const Text(
                              '3',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 5,
                          height: MediaQuery.of(context).size.width / 5,
                          padding: const EdgeInsets.all(2),
                          child: TextButton(
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                  Color(0xFF0B0C0F),
                                ),
                                shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                )),
                            onPressed: () => {
                              setState(() {
                                if (isOperator(
                                    activeIn.substring(activeIn.length - 1))) {
                                  return;
                                }
                                activeIn = '$activeIn%';
                              })
                            },
                            child: const Text(
                              '%',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 5,
                          height: MediaQuery.of(context).size.width / 5,
                          padding: const EdgeInsets.all(2),
                          child: TextButton(
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                  Color(0xFF0B0C0F),
                                ),
                                shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                )),
                            onPressed: () => {
                              setState(() {
                                if (activeIn.isNotEmpty &&
                                    activeIn.substring(activeIn.length - 1) ==
                                        'π') {
                                  return;
                                }
                                activeIn = '$activeInπ';
                              })
                            },
                            child: const Text(
                              'π',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 5,
                          height: MediaQuery.of(context).size.width / 5,
                          padding: const EdgeInsets.all(2),
                          child: TextButton(
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                  Color(0xFF0B0C0F),
                                ),
                                shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                )),
                            onPressed: () => {
                              setState(() {
                                if (isOperator(
                                    activeIn.substring(activeIn.length - 1))) {
                                  return;
                                }
                                activeIn = '$activeIn/';
                              })
                            },
                            child: const Text(
                              '/',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 5,
                          height: MediaQuery.of(context).size.width / 5,
                          padding: const EdgeInsets.all(2),
                          child: TextButton(
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                  Color(0xFF0B0C0F),
                                ),
                                shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                )),
                            onPressed: () => {
                              setState(() {
                                if (isOperator(
                                    activeIn.substring(activeIn.length - 1))) {
                                  return;
                                }
                                activeIn = '$activeIn×';
                              })
                            },
                            child: const Text(
                              '×',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 5,
                          height: MediaQuery.of(context).size.width / 5,
                          padding: const EdgeInsets.all(2),
                          child: TextButton(
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                  Color(0xFF0B0C0F),
                                ),
                                shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                )),
                            onPressed: () => {
                              setState(() {
                                if (isOperator(
                                    activeIn.substring(activeIn.length - 1))) {
                                  return;
                                }
                                activeIn = '$activeIn-';
                              })
                            },
                            child: const Text(
                              '-',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 5,
                          height: MediaQuery.of(context).size.width / 5,
                          padding: const EdgeInsets.all(2),
                          child: TextButton(
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                  Color(0xFF0B0C0F),
                                ),
                                shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                )),
                            onPressed: () => {
                              setState(() {
                                if (isOperator(
                                    activeIn.substring(activeIn.length - 1))) {
                                  return;
                                }
                                activeIn = '$activeIn+';
                              })
                            },
                            child: const Text(
                              '+',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 5,
                          height: MediaQuery.of(context).size.width / 5,
                          padding: const EdgeInsets.all(2),
                          child: TextButton(
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                  Colors.white,
                                ),
                                shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                )),
                            onPressed: () => {
                              setState(() {
                                if (activeIn.isNotEmpty) {
                                  activeIn = activeIn.substring(
                                      0, activeIn.length - 1);
                                }
                              })
                            },
                            child: const Icon(
                              Icons.backspace_rounded,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 5,
                          height: MediaQuery.of(context).size.width / 5,
                          padding: const EdgeInsets.all(2),
                          child: TextButton(
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                  Color(0xFF0B0C0F),
                                ),
                                shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                )),
                            onPressed: () => {
                              setState(() {
                                activeIn = '$activeIn√(';
                              })
                            },
                            child: const Text(
                              '√',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 5,
                          height: MediaQuery.of(context).size.width / 5,
                          padding: const EdgeInsets.all(2),
                          child: TextButton(
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                  Color(0xFF0B0C0F),
                                ),
                                shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                )),
                            onPressed: () => {
                              setState(() {
                                if (isOperator(
                                    activeIn.substring(activeIn.length - 1))) {
                                  return;
                                }
                                activeIn = '$activeIn²';
                              })
                            },
                            child: const Text(
                              'x²',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 5,
                          height: 2 * (MediaQuery.of(context).size.width / 5),
                          padding: const EdgeInsets.all(2),
                          child: TextButton(
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                  Color.fromARGB(255, 19, 185, 250),
                                ),
                                shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                )),
                            onPressed: () async {
                              String expression = activeIn;
                              setState(() {
                                passiveIn = activeIn;
                                activeIn = 'Loading...';
                              });
                              String evaluation = await evaluateOut(expression);
                              dynamic ans = json.decode(evaluation);
                              evaluation = ans["eval"].toString();
                              setState(() {
                                activeIn = evaluation;
                              });
                            },
                            child: const Text(
                              '=',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
