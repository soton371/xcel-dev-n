import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xcel_medical_center/services/lis/pdf_view_count_service.dart';
import 'package:printing/printing.dart';

class PdfReader extends StatefulWidget {
  final String? pdfLink;
  final String? reqId;
  final String? testNo;
  const PdfReader(
      {super.key, @required this.pdfLink, @required this.reqId, @required this.testNo});

  @override
  PdfReaderState createState() => PdfReaderState();
}

class PdfReaderState extends State<PdfReader> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                height: height,
                width: width,
                child: PdfPreview(
                  build: (format) => _generatePdfPreview(),
                  allowSharing: true,
                  allowPrinting: true,
                  useActions: true,
                  pdfFileName: 'Report.pdf',
                  canChangePageFormat: false,
                  
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Uint8List> _generatePdfPreview() async {
    final pdf = await NetworkAssetBundle(
      Uri.parse(widget.pdfLink??''),
    ).load("");
    pdfViewCounterService(widget.reqId??'', widget.testNo??'');
    return pdf.buffer.asUint8List();
  }

}
