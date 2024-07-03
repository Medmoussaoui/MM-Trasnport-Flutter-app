import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/custom_bottom_container.dart';
import 'package:mmtransport/Components/custom_form_faild.dart';
import 'package:mmtransport/Components/custom_large_title.dart';
import 'package:mmtransport/Components/custom_progress_indicator.dart';
import 'package:mmtransport/Components/custom_secondry_button.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:mmtransport/controllers/remaneTable/index.dart';

class RenameTableScreen extends StatelessWidget {
  const RenameTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RenameTableScreenController());
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Stack(
        children: [
          Obx(
            () {
              return Opacity(
                opacity: controller.onSave.value ? 0.5 : 1.0,
                child: AbsorbPointer(
                  absorbing: controller.onSave.value,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: ListView(
                        children: [
                          SizedBox(
                            width: Get.width * 0.25,
                            height: Get.width * 0.25,
                            child: const FittedBox(
                              child: Icon(Icons.table_chart_outlined),
                            ),
                          ),
                          const SizedBox(height: 25),
                          const Center(child: CustomLargeTitle(title: "تغير اسم الجدول", size: 18)),
                          const SizedBox(height: 50),
                          CustomTextFormFaild(
                            controller: controller.tableNameFormController,
                            textAlign: TextAlign.center,
                            hintText: "اسم الجدول الجديد",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const RenameTableButton(),
        ],
      ),
    );
  }
}

class RenameTableButton extends GetView<RenameTableScreenController> {
  const RenameTableButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        bool onSave = controller.onSave.value;
        return Align(
          alignment: Alignment.bottomCenter,
          child: KeyboardVisibilityBuilder(
            builder: (context, isKeyboardVisible) {
              if (isKeyboardVisible) return const SizedBox.shrink();
              return CustomAnimatedBottomContainer(
                visible: ValueNotifier(true),
                child: CustomSecondaryyButton(
                  icon: Icons.add_rounded,
                  title: "حفض التغير",
                  onPressed: () => controller.onTapSave(),
                  bottomPadding: 0,
                  topPadding: 0,
                  child: onSave ? const CustomProgressIndicator() : null,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
