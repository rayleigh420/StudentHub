import 'dart:io';

import 'package:boilerplate/data/network/apis/pdf_api/pdf_api.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path/path.dart';

class PdfViewerPage extends StatefulWidget {
  final File file;
  const PdfViewerPage({super.key, required this.file});

  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  late PDFViewController controller;
  int pages = 0;
  int indexPage = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final name = basename(widget.file.path);
    final String name = widget.file.path.split('/').last.split('?').first;
    final text = '${indexPage + 1} of $pages';

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        actions: pages >= 2
            ? [
                Center(child: Text(text)),
                IconButton(
                  icon: Icon(Icons.chevron_left, size: 32),
                  onPressed: () {
                    final page = indexPage == 0 ? pages : indexPage - 1;
                    controller.setPage(page);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.chevron_right, size: 32),
                  onPressed: () {
                    final page = indexPage == pages - 1 ? 0 : indexPage + 1;
                    controller.setPage(page);
                  },
                ),
              ]
            : null,
      ),
      body: PDFView(
        filePath: widget.file.path,
        // autoSpacing: false,
        // swipeHorizontal: true,
        // pageSnap: false,
        // pageFling: false,
        onRender: (pages) => setState(() => this.pages = pages!),
        onViewCreated: (controller) =>
            setState(() => this.controller = controller),
        onPageChanged: (indexPage, _) =>
            setState(() => this.indexPage = indexPage!),
      ),
    );
  }
}
