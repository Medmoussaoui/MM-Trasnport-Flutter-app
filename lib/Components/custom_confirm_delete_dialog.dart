import 'package:flutter/material.dart';
import 'package:mmtransport/Components/Dialogs/custom_confirm_dialog.dart';

Future<void> customConfirmDeleteDialog({
  String? title,
  String? subTitle,
  Function? onAccept,
  Function? onCancel,
}) {
  return customConfirmDialog(
    onAccept: onAccept,
    onCancel: onCancel,
    confirmTitle: "حذف",
    cancelTitle: "الغاء",
    title: title ?? "تحذير",
    subTitle: subTitle ?? " سيتم فقد البيانات بشكل نهائي عند عملية الحذف",
    color: Colors.red,
    icon: Icons.delete_outline_outlined,
  );
}
