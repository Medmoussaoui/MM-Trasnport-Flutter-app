import 'package:flutter/cupertino.dart';
import 'package:mmtransport/Constant/app.color.dart';

class CustomBottomSheetSlider extends StatelessWidget {
  const CustomBottomSheetSlider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      height: 5,
      width: 50,
      decoration: BoxDecoration(
        color: AppColors.gey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
