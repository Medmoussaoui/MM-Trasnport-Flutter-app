import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/Dialogs/loading_dialog.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:mmtransport/Functions/locale_storage_permitions.dart';
import 'package:mmtransport/class/Pdf/index.dart';
import 'package:mmtransport/class/snackbars.dart';
import 'package:mmtransport/controllers/InvoiceScreen/index.dart';

class DownloadInvoicePdf {
  final InvoiceScreenController controller;

  DownloadInvoicePdf(this.controller);

  showDownloadDoneNotification(String path, String fileName) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 2,
        channelKey: "reminder",
        title: "📥 Download Finished",
        body: "🧾 $fileName",
        category: NotificationCategory.Progress,
        autoDismissible: false,
        payload: {
          'file': fileName,
          'path': path,
        },
      ),
      actionButtons: [
        NotificationActionButton(
          key: "share",
          label: "مشاركة",
          color: AppColors.primaryColor,
          autoDismissible: false,
        ),
        NotificationActionButton(
          key: "open",
          label: "فتح الفاتورة",
          color: AppColors.primaryColor,
          autoDismissible: false,
        ),
      ],
    );
  }

  Future<File> _dowload(String fileName) async {
    final ourPdf = await controller.generateInvoicePdf();
    return await AppPdf.dowloadPdf(ourPdf, fileName);
  }

  Future<void> dowload() async {
    bool access = await permitionToAccessLocalStorage();
    if (access == false) return;
    customLoadingDailog(text: "...جري تحميل الفاتورة");
    final fileName = controller.getInvoicFileName();
    try {
      final file = await _dowload(fileName);
      Get.back();
      showDownloadDoneNotification(file.path, fileName);
    } catch (err) {
      AppSnackBars.problemHappen();
    }
  }
}
