import 'package:flutter/material.dart';
import 'package:nezumi/git_handler.dart';
import 'package:nezumi/qrscanner.dart';

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

  String _gitUrl = "";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Nezumi App!',
            ),
            ElevatedButton(
              onPressed: () {
                _navigateAndGetQRCode(context);
              },
              child: const Text("Scan QR Code!"),
            ),
            Text(
              'URL scanned: $_gitUrl',
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _navigateAndGetQRCode(BuildContext context) async {
    final result = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const QRViewWidget()),
    );

    _gitUrl = result;
    print(_gitUrl);

    String snackbarMsg = "Schedule registered!";

    try {
      fetchGitRepo(_gitUrl);
    } on RepoExistsException catch (e) {
      snackbarMsg = "Schedule ${e.repo} already registered!";
    } on RepoCloneException catch (e) {
      snackbarMsg = "Could not get the Schedule: ${e.stderr}";
    }

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(snackbarMsg)));
  }
}
