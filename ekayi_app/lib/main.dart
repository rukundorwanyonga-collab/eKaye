import 'package:flutter/material.dart';

void main() {
  runApp(const EKayeApp());
}

class EKayeApp extends StatelessWidget {
  const EKayeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'eKaye',
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('eKaye')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.book, size: 100),
            const SizedBox(height: 20),
            const Text(
              'Murakaza neza muri eKaye',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('eKaye irakora!')));
              },
              child: const Text('Kanda hano'),
            ),
          ],
        ),
      ),
    );
  }
}
