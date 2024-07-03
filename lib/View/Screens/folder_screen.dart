import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:mmtransport/View/Widgets/FolderScreen/app_bar.dart';
import 'package:mmtransport/View/Widgets/FolderScreen/body_content.dart';
import 'package:mmtransport/View/Widgets/FolderScreen/search_form.dart';
import 'package:mmtransport/View/Widgets/FolderScreen/select_table_button.dart';
import 'package:mmtransport/class/api_connection.dart';
import 'package:mmtransport/controllers/folders/index.dart';

class FoldersScreen extends StatelessWidget {
  const FoldersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FoldersScreenController());
    controller.getTables();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: customFolderScreenAppBar(controller),
      body: Stack(
        children: [
          Column(
            children: [
              CustomFolderSearchForm(
                onChange: (i) => controller.onSeach(),
                onClear: (i) => controller.clearSearch(),
                searchRequest: controller.searchRequest,
                controller: controller.formSearchController,
              ),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: controller.searchRequest,
                  builder: (_, StatusRequest value, child) {
                    return AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeOut,
                      opacity: value.isLoading ? 0.4 : 1.0,
                      child: CustomFolderScreenBody(
                        groupValue: controller.tableIndex,
                        onTableCardTap: controller.onTableCardTap,
                        request: controller.getTablesRequest,
                      ),
                    );
                  },
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomSelectTableButton(
              onPressed: () {
                controller.openTable();
              },
              visible: controller.isSelectTable,
            ),
          ),
        ],
      ),
    );
  }
}
