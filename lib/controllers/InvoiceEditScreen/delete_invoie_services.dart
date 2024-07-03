import 'package:get/get.dart';
import 'package:mmtransport/Components/Dialogs/loading_dialog.dart';
import 'package:mmtransport/Components/Table/Controller/index.dart';
import 'package:mmtransport/Components/custom_confirm_delete_dialog.dart';
import 'package:mmtransport/Data/Api/invoices.api.dart';
import 'package:mmtransport/class/handle_api_responce_ui.dart';
import 'package:mmtransport/controllers/InvoiceEditScreen/index.dart';

class DeleteInvoiceServiceControler {
  final InvoiceEditScreenController controller;

  DeleteInvoiceServiceControler(this.controller);

  TableDataController get tableController => controller.tableDataController;

  List<int> getServiceIds() {
    List selectRows = tableController.selectRowsController.selectRows;
    List<int> serviceIds = [];
    for (int index in selectRows) {
      int serviceId = tableController.tableRowsData[index].serviceId!;
      serviceIds.add(serviceId);
    }
    return serviceIds;
  }

  deleteServicesFromInvoice(List<int> serviceIds) {
    controller.invoice.services!.removeWhere((service) => serviceIds.contains(service.serviceId));
  }

  // 750
  delete() {
    int invoiceId = controller.invoice.invoiceId!;
    final serviceIds = getServiceIds();
    customConfirmDeleteDialog(
      title: "تأكيد الحذف",
      subTitle: "سيتم حذف العناصر المحدد من الفاتورة فقط ولن يتم فقدها بشكل نهائي",
      onAccept: () async {
        Get.back();
        customLoadingDailog(text: "جري الحذف");
        final res = await InvoicesApi().deleteInvoiceServices(invoiceId, serviceIds);
        Get.back();
        HandleApiResponceUi(onSuccess: (res) {
          controller.tableDataController.removeSelectedRows();
          deleteServicesFromInvoice(serviceIds);
          controller.isMakeChanges = true;
          controller.invoice.refrechAccounting();
        }).handle(res);
      },
    );
  }
}
