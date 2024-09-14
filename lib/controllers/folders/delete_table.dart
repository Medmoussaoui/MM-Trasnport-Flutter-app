import 'package:get/get.dart';
import 'package:mmtransport/Components/Dialogs/loading_dialog.dart';
import 'package:mmtransport/Components/custom_confirm_delete_dialog.dart';
import 'package:mmtransport/Components/hight_security_confirmation.dart';
import 'package:mmtransport/Data/entitys/table.entity.dart';
import 'package:mmtransport/Operations/remove_table.dart';
import '../../Functions/bottom_sheet_bluer.dart';

class DeleteTableConfirmationController {
  final TableEntity table;
  final Function onSuccess;

  DeleteTableConfirmationController({
    required this.table,
    required this.onSuccess,
  });

  Future<bool?> hightDeleteConfirmation(String tableName) async {
    return await customBluerShowBottoSheet(
      HighSecurityConfirmation(
        callback: (confirm) {
          if (confirm) Get.back(result: true);
        },
        name: tableName,
        hintText: "ادخل اسم الجدول",
        subTitle: "عند تاكيد حذف الجدول سيتم حذف جميع بيانات الجدول نهائيا",
      ),
    );
  }

  delete() async {
    Get.back();
    await Future.delayed(const Duration(milliseconds: 200));
    final confirm = await hightDeleteConfirmation(table.tableName!);
    if (confirm != true) return;
    customConfirmDeleteDialog(
      subTitle: "سيتم فقد الجدول بشكل كامل عند عملية الحذف",
      onAccept: () async {
        Get.back();
        customLoadingDailog(text: "جري حذف الجدول");
        bool result = await RemoveTableController(table).remove();
        Get.back(); // for loading dialog
        if (result) {
          onSuccess();
        }
      },
    );
  }
}
