import 'package:flutter/material.dart';

void main() {
  runApp(const MiniCalculatorApp());
}

class MiniCalculatorApp extends StatelessWidget {
  const MiniCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Calculator',
      theme: ThemeData(primarySwatch: Colors.teal, useMaterial3: true),
      home: const CalculatorScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _secondController = TextEditingController();
  String _selectedOperation = 'Add';
  String _result = '';

  void _calculate() {
    final double? a = double.tryParse(_firstController.text);
    final double? b = double.tryParse(_secondController.text);

    if (a == null || b == null) {
      setState(() {
        _result = 'Please enter valid numbers.';
      });
      return;
    }

    setState(() {
      switch (_selectedOperation) {
        case 'Add':
          _result = 'Result: ${a + b}';
          break;
        case 'Subtract':
          _result = 'Result: ${a - b}';
          break;
        case 'Multiply':
          _result = 'Result: ${a * b}';
          break;
        case 'Divide':
          if (b == 0) {
            _result = 'Cannot divide by zero.';
          } else {
            _result = 'Result: ${a / b}';
          }
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mini Calculator'), centerTitle: true),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _firstController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'First number',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _secondController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Second number',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedOperation,
                  items: const [
                    DropdownMenuItem(value: 'Add', child: Text('Add (+)')),
                    DropdownMenuItem(
                      value: 'Subtract',
                      child: Text('Subtract (−)'),
                    ),
                    DropdownMenuItem(
                      value: 'Multiply',
                      child: Text('Multiply (×)'),
                    ),
                    DropdownMenuItem(
                      value: 'Divide',
                      child: Text('Divide (÷)'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedOperation = value!;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Operation',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _calculate,
                  child: const Text('Calculate'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  _result,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.teal,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
