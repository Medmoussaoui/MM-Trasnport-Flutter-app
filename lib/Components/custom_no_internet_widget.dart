import 'package:flutter/material.dart';
import 'package:mmtransport/Components/custom_large_title.dart';

class CustomNoInternetWidget extends StatelessWidget {
  const CustomNoInternetWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.wifi_off_rounded,
          size: 35,
          color: Colors.red,
        ),
        const SizedBox(height: 10),
        CustomLargeTitle(
          title: "لايوجد اتصال بالانترنيت",
          size: 15.0,
          color: Colors.red.withOpacity(0.5),
        ),
      ],
    );
  }
}
