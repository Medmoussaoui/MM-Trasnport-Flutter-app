import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/custom_large_title.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerWidget extends StatefulWidget {
  final String? bottomTitle;
  final IconData? bottomIcon;

  final Function(String code)? onDetect;

  const ScannerWidget({
    Key? key,
    this.onDetect,
    this.bottomIcon,
    this.bottomTitle,
  }) : super(key: key);

  @override
  State<ScannerWidget> createState() => _ScannerWidgetState();
}

class _ScannerWidgetState extends State<ScannerWidget> {
  late MobileScannerController controller;

  @override
  void initState() {
    controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.normal,
      formats: [BarcodeFormat.all],
    );
    super.initState();
  }

  Widget _flashWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: ValueListenableBuilder(
        valueListenable: controller.torchState,
        builder: (context, value, child) {
          bool isFlashOff = value == TorchState.off;
          return IconButton(
            onPressed: () {
              controller.toggleTorch();
            },
            icon: Icon(
              isFlashOff ? Icons.flash_off : Icons.flash_on,
              color: Colors.white,
              size: 30,
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double recHeight = Get.height / 2.7;
    double recWidth = Get.width / 1.5;
    return Stack(
      children: [
        MobileScanner(
          controller: controller,
          scanWindow: Rect.fromLTWH(
            (Get.width / 2) - (recWidth * 0.5),
            (Get.height / 2) - (recHeight * 0.85),
            recWidth,
            recHeight,
          ),
          onDetect: (capture) {
            String barcode = capture.barcodes.last.rawValue.toString();
            if (widget.onDetect != null) {
              widget.onDetect!(barcode);
            }
          },
        ),
        //const CustomOpacityCutScreen(),
        DetecterScennerWidget(recWidth: recWidth, recHeight: recHeight),
        Align(
          alignment: Alignment.topCenter,
          child: _flashWidget(),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: ScannerBottomWidget(
            title: widget.bottomTitle,
            icon: widget.bottomIcon,
          ),
        ),
      ],
    );
  }
}

///
///
///
///

class ScannerBottomWidget extends StatelessWidget {
  final String? title;
  final IconData? icon;

  const ScannerBottomWidget({
    Key? key,
    this.title,
    this.icon,
  }) : super(key: key);

  Widget _title() {
    if (title == null) return const SizedBox.shrink();
    return CustomLargeTitle(
      title: title!,
      color: Colors.white,
      size: 14,
    );
  }

  Widget _icon() {
    if (icon == null) return const SizedBox.shrink();
    return Icon(icon, color: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _title(),
          const SizedBox(height: 8.0),
          _icon(),
        ],
      ),
    );
  }
}

class DetecterScennerWidget extends StatelessWidget {
  const DetecterScennerWidget({
    Key? key,
    required this.recWidth,
    required this.recHeight,
  }) : super(key: key);

  final double recWidth;
  final double recHeight;

  _topCorners() {
    return Row(
      children: [
        Container(
          height: 35,
          width: 35,
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.white, width: 3),
              left: BorderSide(color: Colors.white, width: 3),
            ),
          ),
        ),
        const Spacer(),
        Container(
          height: 35,
          width: 35,
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.white, width: 3),
              right: BorderSide(color: Colors.white, width: 3),
            ),
          ),
        ),
      ],
    );
  }

  _bottomCorners() {
    return Row(
      children: [
        Container(
          height: 35,
          width: 35,
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(color: Colors.white, width: 3),
              bottom: BorderSide(color: Colors.white, width: 3),
            ),
          ),
        ),
        const Spacer(),
        Container(
          height: 35,
          width: 35,
          decoration: const BoxDecoration(
            border: Border(
              right: BorderSide(color: Colors.white, width: 3),
              bottom: BorderSide(color: Colors.white, width: 3),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset((Get.width / 2) - (recWidth * 0.5), (Get.height / 2) - (recHeight * 0.85)),
      child: SizedBox(
        width: recWidth,
        height: recHeight,
        child: Stack(
          children: [
            Column(
              children: [
                _topCorners(),
                const Spacer(),
                _bottomCorners(),
              ],
            ),
            const ScannerCenterRedLine(),
          ],
        ),
      ),
    );
  }
}

///
///
///
///

class ScannerCenterRedLine extends StatefulWidget {
  const ScannerCenterRedLine({
    Key? key,
  }) : super(key: key);

  @override
  State<ScannerCenterRedLine> createState() => _ScannerCenterRedLineState();
}

class _ScannerCenterRedLineState extends State<ScannerCenterRedLine> {
  bool isTop = true;

  void _moveTheLine() {
    setState(() => isTop = !isTop);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _moveTheLine();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedAlign(
      onEnd: _moveTheLine,
      duration: const Duration(milliseconds: 1500),
      curve: Curves.linear,
      alignment: isTop ? Alignment.topCenter : Alignment.bottomCenter,
      child: Container(
        height: 40.0,
        color: Colors.red.withOpacity(0.2),
        child: Center(
          child: Container(
            height: 1.5,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}

///
///
///
///
