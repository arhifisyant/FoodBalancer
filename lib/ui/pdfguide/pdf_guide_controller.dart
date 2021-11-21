import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:get/get.dart';

class PdfGuideController extends GetxController {

  var document = PDFDocument().obs;
  set postDocument(data) => document.value = data;
  PDFDocument get getDocument => document.value;

  var isLoadingObs = true.obs;
  set postIsLoading(data) => isLoadingObs.value = data;
  bool get isLoading => isLoadingObs.value;

  @override
  void onInit() {
    postIsLoading = true;
    _loadDocument();
    super.onInit();
  }

  _loadDocument() {
    PDFDocument.fromAsset('assets/pedoman.pdf')
    .then((value) {
      postIsLoading = false;
      postDocument = value;
    });
  }
}