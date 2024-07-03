import 'package:flutter/cupertino.dart';
import 'package:mmtransport/Constant/app.color.dart';

class DashedLines extends StatelessWidget {
  const DashedLines({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        25,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 2.0),
          height: 2.0,
          width: 7.0,
          decoration: BoxDecoration(
            color: AppColors.geyDeep.withOpacity(0.2),
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }
}
