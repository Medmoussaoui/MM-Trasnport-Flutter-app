import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mmtransport/Components/Table/Controller/index.dart';
import 'package:mmtransport/Components/Table/custom_column.dart';
import 'package:mmtransport/Components/Table/custom_row.dart';
import 'package:mmtransport/Components/Table/empty_row.dart';
import 'package:mmtransport/Components/custom_progress_indicator.dart';
import 'package:mmtransport/Constant/app.color.dart';

class TableDataWidget extends StatelessWidget {
  final TableDataController controller;
  const TableDataWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Table Header
        const SizedBox(height: 0.1),
        BuildTableColumns(controller: controller),
        // Table Rows Data
        Expanded(child: BuildRows(controller: controller)),
      ],
    );
  }
}

class BuildTableColumns extends StatelessWidget {
  final TableDataController controller;

  const BuildTableColumns({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller.refrechColumn,
      builder: (_, value, widget) {
        return Row(
          textDirection: TextDirection.rtl,
          children: List.generate(
            controller.tableColumns.length,
            (index) {
              final column = controller.filterController.getColumnInstance(index);
              return Expanded(
                child: TableColumn(
                  filterState: column == null ? false : column.isFilterd,
                  columnIndex: index,
                  columnName: controller.tableColumns[index],
                  onTap: (index) {
                    controller.showBottomSheetFilter(index);
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class BuildRows extends StatelessWidget {
  final TableDataController controller;
  const BuildRows({Key? key, required this.controller}) : super(key: key);

  Widget _buildEmptyRows() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: 3,
      shrinkWrap: true,
      primary: false,
      itemBuilder: (context, index) {
        return const TableEmptyRow();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller.refrecchRows,
      builder: (_, value, widget) {
        final requestStatus = controller.fetchRowsRequest;
        if (requestStatus.isLoading) {
          return const Center(
            child: CustomProgressIndicator(
              color: AppColors.primaryColor,
            ),
          );
        }
        if (requestStatus.isSuccess && requestStatus.hasData) {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: controller.tableRowsData.length + 1,
            itemBuilder: (context, index) {
              if (index > controller.tableRowsData.length - 1) {
                return _buildEmptyRows();
              }
              return CustomTableRow(
                controller: controller,
                index: index,
              );
            },
          );
        }
        if (requestStatus.isConnectionError) {
          return const Center(child: Text("لايوجد انترنيت"));
        }
        return _buildEmptyRows();
      },
    );
  }
}
