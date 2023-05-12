import 'package:flutter/material.dart';

void main() {
  runApp(const NezumiApp());
}

class NezumiApp extends StatelessWidget {
  const NezumiApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nezumi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const NezumiHomePage(title: 'Nezumi Home Page'),
    );
  }
}

class NezumiHomePage extends StatefulWidget {
  const NezumiHomePage({super.key, required this.title});

  final String title;

  @override
  State<NezumiHomePage> createState() => _NezumiHomePageState();
}

class _NezumiHomePageState extends State<NezumiHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Hello there!',
            ),
          ],
        ),
      ),
    );
  }
}
