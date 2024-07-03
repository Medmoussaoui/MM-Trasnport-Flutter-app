import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Data/entitys/table.entity.dart';
import 'package:mmtransport/Operations/create_table.dart';
import 'package:mmtransport/class/snackbars.dart';

class CreateTableScreenController extends GetxController {
  late TextEditingController tableNameFormController;
  late final Function(TableEntity tableEntity) onTableCreate;
  late final void Function(TableEntity tableEntity) onCreateCallback;
  RxBool onCreate = false.obs;

  String get tableName => tableNameFormController.text;


  onTapCreate() async {
    if (tableName.isEmpty || onCreate.value) return;
    onCreate.value = true;
    final res = await CreateTableController().createTable(tableName);
    onCreate.value = false;
    if (res.isSuccess) {
      successCreateTable();
      onCreateCallback(res.data);
    }
  }

  void successCreateTable() {
    Get.back();
    AppSnackBars.successCreateTable();
  }

  void initialArgements() {
    onCreateCallback = Get.arguments["onCreateCallback"];
    onTableCreate = Get.arguments["onTableCreate"] ?? (table) {};
  }

  @override
  void onClose() {
    tableNameFormController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    initialArgements();
    tableNameFormController = TextEditingController();
    super.onInit();
  }
}
