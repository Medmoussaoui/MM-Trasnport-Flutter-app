import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/custom_large_title.dart';
import 'package:mmtransport/Components/custom_progress_indicator.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:mmtransport/Data/entitys/table.entity.dart';
import 'package:mmtransport/View/Widgets/FolderScreen/table_info_card.dart';
import 'package:mmtransport/class/api_connection.dart';

class CustomFolderScreenBody extends StatelessWidget {
  final ValueNotifier<StatusRequest> request;
  final dynamic Function(int) onTableCardTap;
  final RxInt groupValue;

  const CustomFolderScreenBody({
    super.key,
    required this.groupValue,
    required this.onTableCardTap,
    required this.request,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      child: ValueListenableBuilder(
        valueListenable: request,
        builder: (_, value, child) {
          if (request.value.isLoading) {
            return const Center(
              child: CustomProgressIndicator(
                color: AppColors.primaryColor,
                size: 25,
              ),
            );
          }
          if (request.value.isSuccess && request.value.hasData) {
            final data = (request.value.data as List);
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, index) {
                TableEntity table = request.value.data[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Obx(
                    () {
                      return TableCardInfo(
                        table: table,
                        onTap: onTableCardTap,
                        groupValue: groupValue.value,
                        value: index,
                      );
                    },
                  ),
                );
              },
            );
          }
          if (request.value.isConnectionError) return _noInternet();
          return _noTables();
        },
      ),
    );
  }

  Widget _noInternet() {
    return const Center(
      child: CustomLargeTitle(
        title: "لا يوجد انترنيت",
        size: 17.0,
        color: AppColors.geyDeep,
      ),
    );
  }

  Widget _noTables() {
    return const Center(
      child: CustomLargeTitle(
        title: "لا يوجد جداول",
        size: 17.0,
        color: AppColors.geyDeep,
      ),
    );
  }
}
