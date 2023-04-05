import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const CurrencyConvertorApp());
}

class CurrencyConvertorApp extends StatelessWidget {
  const CurrencyConvertorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency convertor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ConvertorPage(title: 'Currency convertor'),
    );
  }
}

class ConvertorPage extends StatefulWidget {
  const ConvertorPage({super.key, required this.title});

  final String title;

  @override
  State<ConvertorPage> createState() => _ConvertorPageState();
}

class _ConvertorPageState extends State<ConvertorPage> {
  double _ronAmount = 0;
  final _formKey = GlobalKey<FormState>();
  final _inputController = TextEditingController();

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 250,
            child: const Image(
              image: AssetImage('./assets/romanian-money.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 30,
            child: Form(
              key: _formKey,
              child: TextFormField(
                controller: _inputController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^\d+\.?\d*'),
                  ),
                ],
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !RegExp(r'^\d+\.?\d*$').hasMatch(value)) {
                    return 'Please enter a valid decimal number';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Enter the amount in EUR',
                  errorStyle: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                if (_formKey.currentState!.validate()) {
                  _inputController.text != ''
                      ? _ronAmount =
                          double.tryParse(_inputController.text)! * 4.5
                      : _ronAmount = 0;
                }
              });
            },
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(
                Colors.grey,
              ),
              foregroundColor: MaterialStatePropertyAll<Color>(
                Colors.black,
              ),
            ),
            child: const Text(
              'Convert!',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            _ronAmount != 0 ? '${_ronAmount.toString()} RON' : '',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}
