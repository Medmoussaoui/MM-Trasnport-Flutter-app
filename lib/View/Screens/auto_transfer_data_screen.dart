import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mmtransport/Components/custom_large_title.dart';
import 'package:mmtransport/Components/custom_no_internet_widget.dart';
import 'package:mmtransport/Components/custom_refrech_button.dart';
import 'package:mmtransport/Components/custom_secondry_button.dart';
import 'package:mmtransport/Components/device_connection_state_widget.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:mmtransport/Constant/app.images.dart';
import 'package:mmtransport/Data/entitys/transfer.entity.dart';
import 'package:mmtransport/class/api_connection.dart';
import 'package:mmtransport/controllers/auto_transfer_screen_controller.dart';

String subTitle = """
هذه الاداة تقوم بنقل جميع البيانات الجديدة إلى الجداول
الخاصة بها اعتمادا على البيانات الموجود مسبقا
 في الجداول""";

class AutoTransferDataScreen extends StatelessWidget {
  const AutoTransferDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AutoTransferDataScreenController());
    controller.startTransfer();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: WillPopScope(
        onWillPop: () async {
          return await controller.confirmOutOnTransferRun();
        },
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ValueListenableBuilder(
                valueListenable: controller.transferRequest,
                builder: (_, StatusRequest req, child) {
                  return Column(
                    children: [
                      SizedBox(height: Get.height * 0.05),
                      AutoTransferHeadrWidget(request: req),
                      const Spacer(),
                      AutoTransferCustomBody(request: req),
                      AutoTransferRefrechButton(request: req),
                      const Spacer(),
                      AutoTransferCustomBottomButton(request: req),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AutoTransferRefrechButton extends GetView<AutoTransferDataScreenController> {
  final StatusRequest request;

  const AutoTransferRefrechButton({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    if (!request.isSuccess && !request.isLoading) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: CustomRefrechButton(
          onPressed: () => controller.startTransfer(),
        ),
      );
    }
    return const SizedBox();
  }
}

class AutoTransferCustomBody extends GetView<AutoTransferDataScreenController> {
  final StatusRequest request;

  const AutoTransferCustomBody({super.key, required this.request});

  Widget problemHappen() {
    return Column(
      children: [
        const Icon(
          Icons.sync_problem_rounded,
          size: 35,
          color: Colors.orange,
        ),
        const SizedBox(height: 10),
        Text(
          "اوووبس حدثت مشكلة اثناء نقل البيانات",
          style: TextStyle(color: Colors.orange.withOpacity(0.5)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (request.isLoading) return const AutoTransferCustomSyncWidget();
    if (request.isSuccess) return const CustomAutoTransferResult();
    if (request.isConnectionError) return const CustomNoInternetWidget();
    return problemHappen();
  }
}

class CustomAutoTransferResult extends GetView<AutoTransferDataScreenController> {
  const CustomAutoTransferResult({
    super.key,
  });

  Widget resultItam(Color color, String title, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(value, style: TextStyle(color: color)),
        ),
        const Spacer(),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(color: AppColors.geyDeep),
        ),
      ],
    );
  }

  _message() {
    String noTablesFound = "لم يتم التعرف على جداول البيانات  يمكنك القيم بعملية  نقل البيانات بشكل يدوي";
    String foundSomeTable = "ملاحضة يمكنك نقل العصانر التي لم يتم التعرف على الجدول الخاص بها بشكل يدوي";
    String foundAllTable = "تم نقل كل البيانات بنجاح";
    TransferResult result = controller.transferResult;
    if (result.knowTables != 0 && result.unKnowTables != 0) {
      return foundSomeTable;
    }

    if (result.unKnowTables != 0 && result.knowTables == 0) {
      return noTablesFound;
    }
    if (result.unKnowTables == 0 && result.knowTables == 0) {
      return "لاتوجد اي بيانات ليتم نقلها";
    }
    return foundAllTable;
  }

  Widget _messageWidget() {
    return Text(
      _message(),
      textAlign: TextAlign.center,
      style: const TextStyle(),
    );
  }

  @override
  Widget build(BuildContext context) {
    int knowTables = controller.transferResult.knowTables;
    int unKnowTables = controller.transferResult.unKnowTables;
    int total = knowTables + unKnowTables;
    String operationDate = DateFormat.yMMMMd().format(DateTime.now());
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          resultItam(Colors.green, "الجداول المعروفة", "$knowTables/$total"),
          const SizedBox(height: 15),
          resultItam(Colors.red, "الجداول الغير معروفة", "$unKnowTables/$total"),
          const SizedBox(height: 15),
          resultItam(Colors.grey, "تاريخ العملية", operationDate),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Divider(color: AppColors.gey),
          ),
          _messageWidget(),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}

class AutoTransferHeadrWidget extends StatelessWidget {
  final StatusRequest request;

  const AutoTransferHeadrWidget({
    super.key,
    required this.request,
  });

  Widget _defaultHeader() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: CustomLargeTitle(
            title: "نقل البيانات الى الجداول",
            size: 18.0,
          ),
        ),
        Text(
          subTitle,
          textAlign: TextAlign.center,
          style: const TextStyle(color: AppColors.geyDeep),
        ),
      ],
    );
  }

  Widget _successHeader() {
    return Column(
      children: [
        Image.asset(AppImages.success, height: 50),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: CustomLargeTitle(title: "تمت العملية بنجاح", size: 16.5),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (request.isSuccess) return _successHeader();
    return _defaultHeader();
  }
}

class AutoTransferCustomBottomButton extends GetView<AutoTransferDataScreenController> {
  final StatusRequest request;

  const AutoTransferCustomBottomButton({
    super.key,
    required this.request,
  });

  Color _color() {
    if (request.isConnectionError) return Colors.red;
    if (request.isServerFailer || request.isRespondError) return Colors.orange;
    if (request.isSuccess) return AppColors.secondColor;
    return AppColors.primaryColor;
  }

  @override
  Widget build(BuildContext context) {
    return CustomSecondaryyButton(
      title: "العودة",
      icon: Icons.arrow_back,
      color: _color(),
      onPressed: request.isLoading ? null : () => Get.back(),
    );
  }
}

class AutoTransferCustomSyncWidget extends StatelessWidget {
  const AutoTransferCustomSyncWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SyncIconWidget(
          color: AppColors.primaryColor,
          size: 35,
        ),
        SizedBox(height: 10),
        Text(
          "...المرجو الانتضار",
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.geyDeep),
        ),
      ],
    );
  }
}
