import 'events.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    List<Card> Cards = [];
    for (var i = 0; i < Events.length; i++) {
      Cards.add(Card(
          shadowColor: Colors.grey,
          color: Color(0xe2d5f5).withOpacity(0.9),
          clipBehavior: Clip.hardEdge,
          child: InkWell(
              hoverColor: Colors.purple.withOpacity(1),
              splashColor: Color(0xc6aaf0).withAlpha(1000).withOpacity(0.8),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SecondRoute()),
                );
                debugPrint('Card tapped.');
              },
              child: Container(
                height: 100,
                padding: EdgeInsets.all(20),
                child: Text(Events[i].Title +
                    '\n\n' +
                    DateFormat.yMMMd().format(Events[i].date)),
              ))));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(50),
        itemCount: Events.length,
        separatorBuilder: (context, index) {
          return const SizedBox(height: 15);
        },
        itemBuilder: (context, index) {
          print(index);
          return Cards[index];
        },
      ),
    );
  }

  Future<void> _navigateAndGetQRCode(BuildContext context) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const QRViewWidget()),
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

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
