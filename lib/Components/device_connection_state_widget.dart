import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/syncData/lisener.dart';

class DeviceConnectionStateWidget extends StatelessWidget {
  const DeviceConnectionStateWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SyncDataContainerLisener>();
    return ValueListenableBuilder(
      valueListenable: controller.deviceState,
      builder: (_, value, child) {
        return GestureDetector(
          onTap: () => controller.showSyncStateDialog(),
          child: Builder(
            builder: (_) {
              if (value == DeviceConnectionState.online) {
                return const Icon(Icons.cloud_done_outlined, size: 25);
              }
              if (value == DeviceConnectionState.syncing) {
                return const SyncIconWidget();
              }
              if (value == DeviceConnectionState.syncProblem) {
                return const Icon(Icons.sync_problem, size: 25);
              }
              if (value == DeviceConnectionState.noInternetAccess) {
                return const Icon(Icons.cloud_off_outlined, size: 25);
              }
              return const Icon(Icons.phone_android_outlined, size: 25);
            },
          ),
        );
      },
    );
  }
}

class SyncIconWidget extends StatefulWidget {
  final Color? color;
  final double? size;
  const SyncIconWidget({super.key, this.color, this.size});

  @override
  State<SyncIconWidget> createState() => _SyncIconWidgetState();
}

class _SyncIconWidgetState extends State<SyncIconWidget> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> size;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 5));
    size = Tween<double>(begin: 1, end: 11).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: size.value,
      child: Icon(
        Icons.sync,
        size: widget.size ?? 25,
        color: widget.color,
      ),
    );
  }
}
