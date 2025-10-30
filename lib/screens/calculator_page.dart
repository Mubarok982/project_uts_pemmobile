import 'package:flutter/material.dart';
import 'dart:math';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String input = '';
  String output = '0';

  void buttonPressed(String value) {
    setState(() {
      if (value == 'C') {
        input = '';
        output = '0';
      } else if (value == '⌫') {
        if (input.isNotEmpty) input = input.substring(0, input.length - 1);
      } else if (value == '=') {
        try {
          output = _calculate(input);
        } catch (e) {
          output = 'Error';
        }
      } else {
        input += value;
      }
    });
  }

  String _calculate(String exp) {
    exp = exp.replaceAll('×', '*').replaceAll('÷', '/');
    try {
      double result = _evaluateExpression(exp);
      // tampilkan angka tanpa koma berlebih
      return result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 5);
    } catch (e) {
      return 'Error';
    }
  }

  /// Fungsi evaluasi ekspresi dengan prioritas operator (× ÷ > + -)
  double _evaluateExpression(String expr) {
    expr = expr.replaceAll(' ', '');
    List<String> tokens = _tokenize(expr);

    // Tangani perkalian dan pembagian lebih dulu
    for (int i = 0; i < tokens.length; i++) {
      if (tokens[i] == '*' || tokens[i] == '/') {
        double a = double.parse(tokens[i - 1]);
        double b = double.parse(tokens[i + 1]);
        double res = tokens[i] == '*' ? a * b : (b != 0 ? a / b : double.infinity);
        tokens.replaceRange(i - 1, i + 2, [res.toString()]);
        i -= 1;
      }
    }

    // Tangani penjumlahan dan pengurangan
    double result = double.parse(tokens[0]);
    for (int i = 1; i < tokens.length; i += 2) {
      String op = tokens[i];
      double next = double.parse(tokens[i + 1]);
      if (op == '+') result += next;
      if (op == '-') result -= next;
    }

    return result;
  }

  List<String> _tokenize(String expr) {
    final regex = RegExp(r'(\d+\.?\d*|\+|\-|\*|\/)');
    return regex.allMatches(expr).map((m) => m.group(0)!).toList();
  }

  final List<String> buttons = [
    'C', '⌫', '÷', '×',
    '7', '8', '9', '-',
    '4', '5', '6', '+',
    '1', '2', '3', '=',
    '0', '.', 
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3E5F5),
      appBar: AppBar(
        title: const Text('Kalkulator Android'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Tampilan input
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              input,
              style: const TextStyle(fontSize: 28, color: Colors.black54),
            ),
          ),
          // Tampilan hasil
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              output,
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(),
          // Tombol-tombol
          Expanded(
            flex: 2,
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: buttons.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final value = buttons[index];
                Color color = Colors.deepPurple.shade100;
                Color textColor = Colors.deepPurple;

                if (['C', '⌫'].contains(value)) {
                  color = Colors.red.shade100;
                  textColor = Colors.red;
                } else if (['÷', '×', '-', '+', '='].contains(value)) {
                  color = Colors.deepPurple;
                  textColor = Colors.white;
                }

                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    foregroundColor: textColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => buttonPressed(value),
                  child: Text(
                    value,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
