import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/Dialogs/loading_dialog.dart';
import 'package:mmtransport/Components/custom_bottom_sheet_generate_invoice.dart';
import 'package:mmtransport/Components/custom_confirm_delete_dialog.dart';
import 'package:mmtransport/Data/entitys/table.entity.dart';
import 'package:mmtransport/Functions/show_bottom_sheet.dart';
import 'package:mmtransport/Operations/get_tables.dart';
import 'package:mmtransport/Operations/remove_table.dart';
import 'package:mmtransport/View/Widgets/TableScreen/table_menu_bottom_sheet.dart';
import 'package:mmtransport/class/api_connection.dart';
import 'package:mmtransport/class/redirect_to.dart';
import 'package:mmtransport/class/snackbars.dart';
import 'package:mmtransport/controllers/GenerateInvoice/generate_table_invoice.dart';

class FoldersScreenController extends GetxController {
  GetTablesController getTablesController = GetTablesController();
  TextEditingController formSearchController = TextEditingController();
  ValueNotifier<StatusRequest> searchRequest = ValueNotifier(StatusRequest());
  ValueNotifier<StatusRequest> getTablesRequest = ValueNotifier(StatusRequest());
  ValueNotifier<bool> isSelectTable = ValueNotifier(false);
  RxInt tableIndex = RxInt(-1);

  List<TableEntity> tables = [];

  String get searchInput => formSearchController.value.text;

  void refrechTables(List<TableEntity> tables) {
    tableIndex.value = -1;
    isSelectTable.value = false;
    getTablesRequest.value = StatusRequest(data: tables).success();
  }

  Future<void> showTableMenu() async {
    return await customShowBottoSheet(
      TableMenuBottmSheet(
        onRename: () async {
          Get.back();
          await Future.delayed(const Duration(milliseconds: 200));
          redirectToRenameTable();
        },
        onDelete: () => deleteTable(),
        onNewInvoice: generateTableInvoice,
        onInvoiceStore: () async {
          Get.back();
          await Future.delayed(const Duration(milliseconds: 200));
          final table = tables[tableIndex.value];
          RedirectTo.tableInvoiceStoreScreen(table: table);
        },
      ),
    );
  }

  generateTableInvoice() async {
    Get.back();
    await Future.delayed(const Duration(milliseconds: 300));
    final table = tables[tableIndex.value];
    customShowBottoSheet(
      isDismissible: false,
      CustomBottomSheetGenerateInvoice(
        controller: GenereteTableInvoiceController(table),
      ),
    );
  }

  deleteTable() async {
    Get.back();
    await Future.delayed(const Duration(milliseconds: 200));
    customConfirmDeleteDialog(
      subTitle: "سيتم فقد الجدول بشكل كامل عند عملية الحذف",
      onAccept: () async {
        Get.back();
        customLoadingDailog(text: "جري حذف الجدول");
        final table = getTablesRequest.value.data[tableIndex.value];
        bool result = await RemoveTableController(table).remove();
        Get.back(); // for loading dialog
        if (result) {
          tables.remove(table);
          clearSearch();
          AppSnackBars.successDeleteTable();
        }
      },
    );
  }

  void deleteTableById(int id) {
    tables.removeWhere((table) => table.id == id);
    refrechTables(tables);
  }

  void onTableCardTap(int index) {
    if (index == tableIndex.value) {
      tableIndex.value = -1;
      isSelectTable.value = false;
      return;
    }
    tableIndex.value = index;
    isSelectTable.value = true;
  }

  TableEntity currentTable() {
    return getTablesRequest.value.data[tableIndex.value];
  }

  Future<void> getTables() async {
    getTablesRequest.value = getTablesRequest.value.loading();
    final res = await getTablesController.getTables();
    if (res.isSuccess) tables = List.of(res.data);
    getTablesRequest.value = res;
  }

  Future<void> onSeach() async {
    tableIndex.value = -1;
    searchRequest.value = StatusRequest().loading();
    if (searchInput.isEmpty) {
      getTablesRequest.value.data = List.from(tables);
      searchRequest.value = StatusRequest().success();
      return;
    }
    final result = tables.where((table) => table.tableName!.contains(searchInput)).toList();
    getTablesRequest.value.data = result;
    searchRequest.value = StatusRequest().success();
  }

  void clearSearch() {
    tableIndex.value = -1;
    isSelectTable.value = false;
    formSearchController.clear();
    getTablesRequest.value = StatusRequest(data: tables).success();
  }

  void openTable() {
    RedirectTo.tableScreen(tableEntity: currentTable());
  }

  void redirectToCreateTable() {
    RedirectTo.createTableScreen(
      onCreateCallback: (table) async {
        tables.insert(0, table);
        refrechTables(tables);
      },
    );
  }

  void redirectToRenameTable() {
    RedirectTo.renameTableScreen(
      table: currentTable(),
      onRenameSaved: (table) {
        tables[tableIndex.value] = table;
        refrechTables(tables);
      },
    );
  }

  @override
  void onClose() {
    formSearchController.dispose();
    isSelectTable.dispose();
    super.onClose();
  }
}
