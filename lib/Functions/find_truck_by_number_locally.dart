import 'package:mmtransport/Data/entitys/truck_entity.dart';
import 'package:mmtransport/Data/local/trucks.local.dart';

Future<bool> findTruckByNumberLocally(String truckNumber) async {
  TruckEntity? truck = await TruckLocal.getTruckByNumber(truckNumber);
  return (truck != null);
}
