import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class AppPdf {
  static late Font arabicNormalFont;
  static late Font arabicBoldFont;

  static initi() async {
    final fontOne = await rootBundle.load("assets/fonts/NotoNaskhArabic-Medium.ttf");
    final fontTwo = await rootBundle.load("assets/fonts/NotoNaskhArabic-Bold.ttf");
    
    arabicNormalFont = Font.ttf(fontOne);
    arabicBoldFont = Font.ttf(fontTwo);
  }

  static Future<Uint8List> generatePdf(List<Widget> page) async {
    final pdf = Document();
    pdf.addPage(
      MultiPage(
        maxPages: 300,
        pageTheme: PageTheme(
          margin: const EdgeInsets.symmetric(vertical: 20),
          pageFormat: PdfPageFormat.a4,
          textDirection: TextDirection.rtl,
          theme: ThemeData(
            defaultTextStyle: TextStyle(
              fontNormal: arabicNormalFont,
              fontBold: arabicBoldFont,
            ),
          ),
        ),
        build: (context) => page,
      ),
    );
    return pdf.save();
  }

  static Future<File> dowloadPdf(List<int> bytes, String fileName) async {
    final directory = await getExternalFolerToStoreOurPdfs();
    final file = File("${directory.path}/$fileName");
    return await file.writeAsBytes(bytes);
  }

  static Future<Directory> getExternalFolerToStoreOurPdfs() async {
    Directory? directory = await getExternalStorageDirectory();
    String newPath = "";
    List<String> paths = directory!.path.split("/");
    for (int x = 1; x < paths.length; x++) {
      String folder = paths[x];
      if (folder != "Android") newPath += "/$folder";
      if (folder == "Android") break;
    }
    newPath = "$newPath/Mm-Transport Invoices";
    directory = Directory(newPath);
    bool isDirectoryExist = await directory.exists();
    if (!isDirectoryExist) await directory.create(recursive: true);
    return directory;
  }

  static openPdf(String path) {}
}
