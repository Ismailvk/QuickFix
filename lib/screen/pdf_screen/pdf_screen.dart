import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:share_plus/share_plus.dart';

class PdfViewerPage extends StatelessWidget {
  final String pdfPath;

  const PdfViewerPage(this.pdfPath, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back_ios_new)),
        title: const Text('PDF Viewer'),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.all(10),
            height: size.height,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.0),
              ),
              child: Center(
                child: SizedBox(
                  width: double.infinity,
                  child: PDFView(filePath: pdfPath),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green.shade300,
          hoverColor: Colors.grey,
          onPressed: () => sharePdf(pdfPath),
          child: const Icon(Icons.share)),
    );
  }

  Future<void> sharePdf(String path) async {
    try {
      final file = File(path);
      if (await file.exists()) {
        // ignore: deprecated_member_use
        await Share.shareFiles([path], text: 'Sharing PDF file');
      }
    } catch (e) {
      debugPrint('Error sharing PDF: $e');
    }
  }
}
