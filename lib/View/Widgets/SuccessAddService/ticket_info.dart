import 'package:flutter/material.dart';
import 'package:mmtransport/Components/custom_large_title.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:mmtransport/Data/entitys/service_entity.dart';
import 'package:mmtransport/Functions/dates.dart';
import 'package:mmtransport/View/Widgets/SuccessAddService/ticket_item.dart';

class TicketInfo extends StatelessWidget {
  final ServiceEntity service;

  const TicketInfo({
    required this.service,
    Key? key,
  }) : super(key: key);

  String _getServicStatus() {
    return (service.payFrom != null) ? "مدفوعة" : "غير مدفوعة";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 360,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 13),
            child: CustomLargeTitle(
              title: "معلومات الخدمة",
              size: 16,
              color: AppColors.blueGrey,
            ),
          ),
          Divider(
            height: 0.0,
            color: AppColors.geyDeep.withOpacity(0.2),
            thickness: 1,
          ),
          const SizedBox(height: 14),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TicketItem(title: "اسم القارب", value: service.boatName!),
                  TicketItem(title: "نوع الخدمة", value: service.serviceType!),
                  TicketItem(title: "الثمن", value: "${service.price!} dh"),
                  TicketItem(title: "رقم الشاحنة", value: service.truckNumber!),
                  TicketItem(title: "التاريخ", value: getDate(service.dateCreate!)),
                  TicketItem(title: "الوقت", value: getTime(service.dateCreate!)),
                  TicketItem(title: "الحالة", value: _getServicStatus()),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
        ],
      ),
    );
  }
}
