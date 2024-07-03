import 'package:flutter/material.dart';
import 'package:mmtransport/Components/custom_large_title.dart';
import 'package:mmtransport/Data/entitys/service_entity.dart';
import 'package:mmtransport/Functions/dates.dart';

class CustomServiceMoreInfoTruckInfo extends StatelessWidget {
  final ServiceEntity serviceEntity;

  const CustomServiceMoreInfoTruckInfo({
    super.key,
    required this.serviceEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        children: [
          TruckInfoItem(title: "السائق", value: serviceEntity.driverName ?? "n/n"),
          TruckInfoItem(title: "رقم الشاحنة", value: serviceEntity.truckNumber ?? "n/n"),
          TruckInfoItem(title: "صاحب الشاحنة", value: serviceEntity.truckOwner ?? "n/n"),
          TruckInfoItem(title: "الوقت", value: getTime(serviceEntity.dateCreate!)),
        ],
      ),
    );
  }
}

class TruckInfoItem extends StatelessWidget {
  final String title;
  final String value;

  const TruckInfoItem({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          CustomLargeTitle(
            title: value,
            size: 16.0,
          ),
        ],
      ),
    );
  }
}
