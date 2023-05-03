import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:googleapis/drive/v3.dart' as drive;

class PdfListScreen extends StatelessWidget {
  final List<drive.File> files;

  const PdfListScreen(this.files, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF List'),
      ),
      body: ListView.builder(
        itemCount: files.length,
        itemBuilder: (BuildContext context, int index) {
          final file = files[index];
          return ListTile(
            leading: Icon(Icons.file_copy),
            title: Text(file.name!),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PdfViewerScreen(file.id!),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class PdfViewerScreen extends StatefulWidget {
  final String fileId;

  const PdfViewerScreen(this.fileId, {super.key});

  @override
  _PdfViewerScreenState createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  final flutterWebviewPlugin = FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();
    flutterWebviewPlugin.launch('https://drive.google.com/file/d/${widget.fileId}/preview');
  }

  @override
  void dispose() {
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      url: 'https://drive.google.com/file/d/${widget.fileId}/preview',
    );
  }
}
