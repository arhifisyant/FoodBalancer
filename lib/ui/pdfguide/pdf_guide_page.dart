import 'package:food_balancer/ui/pdfguide/pdf_guide_controller.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PdfGuidePage extends StatelessWidget {
  late PdfGuideController _taskController;

  @override
  Widget build(BuildContext context) {
    _taskController = Get.put(PdfGuideController());
    return Scaffold(
      appBar: AppBar(title: Text("Pedoman Gizi Seimbang"),),
      body: Center(
        child: Obx(()=> _taskController.isLoading?Center(child: CircularProgressIndicator()):PDFViewer(
          document: _taskController.getDocument,
          zoomSteps: 1,
        )),
      ),
    );
  }
}