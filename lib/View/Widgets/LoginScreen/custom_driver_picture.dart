import 'package:flutter/cupertino.dart';
import 'package:mmtransport/Constant/app.images.dart';

class DriverPicture extends StatelessWidget {
  const DriverPicture({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: 120,
      child: Image.asset(AppImages.driver),
    );
  }
}
