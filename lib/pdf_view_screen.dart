import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfViewScreen extends StatefulWidget {
  final String pdfPath;
  final String pdfName;
  const PdfViewScreen(
      {super.key, required this.pdfName, required this.pdfPath});

  @override
  State<PdfViewScreen> createState() => _PdfViewScreenState();
}

class _PdfViewScreenState extends State<PdfViewScreen> {
  int totalPages = 0;
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.pdfName),
      ),
      body: PDFView(
        filePath: widget.pdfPath,
        pageFling: false,
        autoSpacing: false,
        onRender: (pages){
          setState(() {
            totalPages = pages!;
          });
        },
        onPageChanged: (page, total){
          setState(() {
            currentPage = page!;
          });
        },
      ),
    );
  }
}
