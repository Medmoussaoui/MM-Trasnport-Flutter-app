import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/custom_bottom_container.dart';
import 'package:mmtransport/Components/custom_secondry_button.dart';
import 'package:mmtransport/controllers/TransferScreen/index.dart';

class CustomTransferFolderScreenButton extends GetView<FoldersTransferScreenController> {
  const CustomTransferFolderScreenButton({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isVisible) {
        if (isVisible) return const SizedBox.shrink();
        return CustomAnimatedBottomContainer(
          visible: controller.isSelectTable,
          child: CustomSecondaryyButton(
            title: "نقل العناصر",
            icon: Icons.move_up_rounded,
            topPadding: 0,
            bottomPadding: 0,
            onPressed: () {
              controller.transferToCurrentTable();
            },
          ),
        );
      },
    );
  }
}
