import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/custom_large_title.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:mmtransport/Data/entitys/truck_entity.dart';
import 'package:mmtransport/controllers/SelectTruck/index.dart';

class CustomTruckItem extends GetView<SelectTruckScreenController> {
  final int index;
  final int groupValue;
  final void Function(int index) onTap;

  const CustomTruckItem({
    Key? key,
    required this.index,
    required this.groupValue,
    required this.onTap,
  }) : super(key: key);

  bool _isSelected() {
    return index == groupValue;
  }

  Border _border() {
    bool whiteBorderColor = _isSelected() || (groupValue - 1) == index;
    return Border(
      bottom: BorderSide(
        color: whiteBorderColor ? Colors.white : AppColors.backgroundColor,
        width: 1.5,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TruckEntity truck = controller.truckListController.trucks[index];
    return GestureDetector(
      onTap: () {
        onTap(index);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: _border(),
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          color: _isSelected() ? AppColors.secondColor.withOpacity(0.1) : Colors.white,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: CustomLargeTitle(
                title: truck.truckNumber,
                size: 17,
                color: _isSelected() ? AppColors.therdColor : AppColors.primaryColor,
              ),
            ),
            leading: Icon(
              Icons.local_shipping_outlined,
              size: 30,
              color: _isSelected() ? AppColors.therdColor : AppColors.secondColor,
            ),
            subtitle: Text(
              truck.truckName,
              style: TextStyle(
                color: _isSelected() ? AppColors.therdColor : AppColors.geyDeep,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            trailing: SizedBox(
              width: Get.width * 0.4,
              child: Align(
                alignment: Alignment.centerRight,
                child: FittedBox(
                  child: Text(
                    truck.truckOwner,
                    style: TextStyle(
                      color: _isSelected() ? AppColors.therdColor : Colors.black87,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
