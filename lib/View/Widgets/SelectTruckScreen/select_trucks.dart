import 'package:flutter/material.dart';
import 'package:mmtransport/Components/custom_progress_indicator.dart';
import 'package:mmtransport/View/Widgets/SelectTruckScreen/select_truck_button.dart';
import 'package:mmtransport/View/Widgets/SelectTruckScreen/select_truck_item.dart';
import 'package:mmtransport/controllers/SelectTruck/select_truck_from_list.dart';

class CustomSelectTruckList extends StatefulWidget {
  final SelectTruckListController controller;
  const CustomSelectTruckList({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<CustomSelectTruckList> createState() => _CustomSelectTruckListState();
}

class _CustomSelectTruckListState extends State<CustomSelectTruckList> {
  int groupValue = -1;

  void _onSelectItem(int index) {
    int value = (groupValue == index) ? -1 : index;
    widget.controller.currentTruck = value;
    setState(() => groupValue = value);
  }

  @override
  void initState() {
    widget.controller.loadTrucks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ValueListenableBuilder(
            valueListenable: widget.controller.stateChange,
            builder: (_, value, child) {
              if (widget.controller.getTrucksRequest.isLoading) {
                return const Center(
                  child: CustomProgressIndicator(
                    color: Colors.black87,
                  ),
                );
              }
              if (widget.controller.trucks.isNotEmpty) {
                return ListView.builder(
                  itemCount: widget.controller.trucks.length,
                  itemBuilder: (context, index) {
                    return CustomTruckItem(
                      index: index,
                      groupValue: groupValue,
                      onTap: _onSelectItem,
                    );
                  },
                );
              }
              if (!widget.controller.getTrucksRequest.isConnectionError) {
                return const Center(child: Text("لا يوجد انترنيت"));
              }
              return const Center(child: Text("لا توجد بيانات"));
            }),
        Align(
          alignment: Alignment.bottomCenter,
          child: CustomSelectTruckItemButton(
            groupValue: groupValue,
            loading: widget.controller.onContinue.value,
            ontap: widget.controller.selctAndContinue,
          ),
        ),
      ],
    );
  }
}
