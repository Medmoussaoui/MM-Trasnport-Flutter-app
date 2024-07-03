import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/Dialogs/loading_dialog.dart';
import 'package:mmtransport/Data/entitys/table.entity.dart';
import 'package:mmtransport/Operations/get_tables.dart';
import 'package:mmtransport/controllers/TransferScreen/get_tables.dart';
import 'package:mmtransport/controllers/folders/index.dart';

class FoldersTransferScreenController extends FoldersScreenController {
  late TableEntity? from;
  late int totalTransfer;
  late void Function(bool result) onTrasferCallBack;
  late Future<bool> Function(TableEntity table) transfer;

  ValueNotifier<bool> onTransfer = ValueNotifier(false);

  transferToCurrentTable() async {
    if (!isSelectTable.value || onTransfer.value) return;
    onTransfer.value = true;
    customLoadingDailog(text: "جري نقل العناصر");
    bool result = await transfer(currentTable());
    onTransfer.value = false;
    Get.back();
    Get.back();
    onTrasferCallBack(result);
    // if success get back
    // else show dialog for the essu reasion
  }

  @override
  GetTablesController get getTablesController => GetTransferTablesController(from);

  void initialArguments() {
    totalTransfer = Get.arguments["totalTransfer"];
    onTrasferCallBack = Get.arguments["onTransferCallback"];
    transfer = Get.arguments["transfer"];
    from = Get.arguments["from"];
  }

  @override
  void onInit() {
    initialArguments();
    super.onInit();
  }
}
