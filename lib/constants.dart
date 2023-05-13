import 'package:path_provider/path_provider.dart' as path_provider;

String _baseDirectory = "";

Future<String> localPath() async {
  if (_baseDirectory == "") {
    final directory = await path_provider.getApplicationDocumentsDirectory();
    _baseDirectory = directory.path;
  }

  return _baseDirectory;
}
