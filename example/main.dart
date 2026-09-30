import 'package:ez_password_field/ez_password_field.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EzPasswordField Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'EzPasswordField Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text('Default field:'),
              const EzPasswordField(),
              const SizedBox(height: 20),
              const Text('Min length 12:'),
              const EzPasswordField(minLength: 12),
              const SizedBox(height: 20),
              const Text('PIN-code like field:'),
              const EzPasswordField(
                labelText: 'PIN',
                requireUppercase: false,
                requireLowercase: false,
                requireSpecialChars: false,
                prohibitLetters: true,
                minLength: 4,
              ),
              const SizedBox(height: 20),
              const Text('No special chars allowed:'),
              const EzPasswordField(prohibitSpecialChars: true),
              const SizedBox(height: 20),
              const Text('With custom validator (must contain \'ez\'):'),
              EzPasswordField(
                validator: (value) {
                  if (value?.contains('ez') == false) {
                    return 'Must contain \'ez\'';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const Text('With custom decoration:'),
              const EzPasswordField(
                decoration: InputDecoration(
                  labelText: 'Enter Code',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.lightBlueAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
