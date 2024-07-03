import 'package:flutter/cupertino.dart';
import 'package:mmtransport/Data/entitys/service_entity.dart';
import 'package:mmtransport/View/Widgets/SuccessAddService/dashed_lines.dart';
import 'package:mmtransport/View/Widgets/SuccessAddService/print_ticket_button.dart';
import 'package:mmtransport/View/Widgets/SuccessAddService/ticket_info.dart';

class CustomTicketService extends StatelessWidget {
  final ServiceEntity service;

  const CustomTicketService({
    required this.service,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TicketInfo(service: service),
        const DashedLines(),
        const PrintTicketButton(),
      ],
    );
  }
}
