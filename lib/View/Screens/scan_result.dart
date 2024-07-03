import 'package:flutter/material.dart';

class SearchOnTrucks extends StatelessWidget {
  final String barcode;
  final void Function()? onback;
  const SearchOnTrucks({Key? key, required this.barcode, this.onback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (onback != null) onback!();
        return true;
      },
      child: Scaffold(
        body: Center(
          child: Text(barcode, style: const TextStyle(color: Colors.black, fontSize: 16)),
        ),
      ),
    );
  }
}
