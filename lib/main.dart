import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = "0";
  String _outputBuffer = "0";
  double _num1 = 0;
  double _num2 = 0;
  String _operand = "";

 void _buttonPressed(String buttonText) {
  if (buttonText == "C") {
    _output = "0";
    _outputBuffer = "0";
    _num1 = 0;
    _num2 = 0;
    _operand = "";
  } else if (buttonText == "+" || buttonText == "-" || buttonText == "*" || buttonText == "/") {
    _num1 = double.parse(_outputBuffer);
    _operand = buttonText;
    _outputBuffer = ""; // Clear the buffer for the next number
  } else if (buttonText == ".") {
    if (!_outputBuffer.contains(".")) {
      _outputBuffer += buttonText;
    }
  } else if (buttonText == "=") {
    _num2 = double.parse(_outputBuffer);
    double result=0.0;
    // Perform calculation based on the operand
    switch (_operand) {
      case "+":
        result = _num1 + _num2;
        break;
      case "-":
        result = _num1 - _num2;
        break;
      case "*":
        result = _num1 * _num2;
        break;
      case "/":
        if (_num2 != 0) {
          result = _num1 / _num2;
        } else {
          // Handle division by zero error
          result = double.nan; // or any other appropriate value
        }
        break;
    }
    // Update _output with the result
    _output = result.toStringAsFixed(2);
    // Reset _outputBuffer and _operand for the next calculation
    _outputBuffer = _output;
    _operand = "";
  } else {
    _outputBuffer += buttonText;
  }

  setState(() {
    _output = double.parse(_outputBuffer).toStringAsFixed(2);
  });
}

  Widget _buildButton(String buttonText) {
    return Expanded(
      child: ElevatedButton(
        
        onPressed: () => _buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
              child: Text(
                _output,
                style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Divider(),
            ),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    _buildButton("7"),
                    _buildButton("8"),
                    _buildButton("9"),
                    _buildButton("/"),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildButton("4"),
                    _buildButton("5"),
                    _buildButton("6"),
                    _buildButton("*"),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildButton("1"),
                    _buildButton("2"),
                    _buildButton("3"),
                    _buildButton("-"),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildButton("."),
                    _buildButton("0"),
                    _buildButton("00"),
                    _buildButton("+"),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildButton("C"),
                    _buildButton("="),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}