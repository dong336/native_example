import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SendDataExample extends StatefulWidget {
  const SendDataExample({super.key});

  @override
  State<StatefulWidget> createState() => _SendDataExample();
}

class _SendDataExample extends State<SendDataExample> {
  static const platform = MethodChannel('com.flutter.dev/encrypto');

  TextEditingController controller = TextEditingController();
  String _changeText = 'Nothing';
  String _reChangedText = 'Nothing';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Data Example'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: controller,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                _changeText,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  print(_changeText);
                  _decodeText(_changeText);
                },
                child: const Text('디코딩하기'),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                _reChangedText,
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _sendData(controller.value.text);
        },
        child: const Text('변환'),
      ),
    );
  }

  void _decodeText(String changeText) async {
    final String result = await platform.invokeMethod('getDecode', changeText);
    setState(() {
      _reChangedText = result;
    });
  }

  Future<void> _sendData(String text) async {
    final String result = await platform.invokeMethod('getEncrypto', text);
    print(result);
    setState(() {
      _changeText = result;
    });
  }
}