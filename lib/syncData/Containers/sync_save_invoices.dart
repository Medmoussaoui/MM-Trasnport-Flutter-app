import 'package:mmtransport/Data/Api/invoices.api.dart';
import 'package:mmtransport/class/api_connection.dart';
import 'package:mmtransport/syncData/model.dart';

class SyncSaveInvoices extends SyncContainer {
  SyncSaveInvoices() : super(storeContainer);

  @override
  Future<void> forse(item) async {}

  static SyncTableScheama storeContainer = SyncTableScheama(
    tableName: "SyncSaveInvoices",
    columns: [
      SyncTableColumn(columnName: "invoiceId", dataType: TableColumnDataType.integer),
    ],
  );

  static Future<void> addToSync(int invoiceId) async {
    await storeContainer.initial();
    await storeContainer.insert({"invoiceId": invoiceId});
  }

  @override
  Future<StatusRequest> request(item) async {
    int invoiceId = item["invoiceId"];
    final res = await InvoicesApi().saveInvoice(invoiceId);
    String noInvoice = "No Invoice Found";
    if (!res.isSuccess && res.data == noInvoice) {
      return StatusRequest().success();
    }
    return res;
  }
}
