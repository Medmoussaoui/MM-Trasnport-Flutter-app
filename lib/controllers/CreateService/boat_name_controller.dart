import 'package:mmtransport/Components/Form-suggested/controller.dart';
import 'package:mmtransport/Data/Api/keywords.api.dart';
import 'package:mmtransport/Data/local/service_keywords.local.dart';
import 'package:mmtransport/class/api_connection.dart';

class BoatNameController extends TextFormWithSuggestedController {
  BoatNameController(String? initialValue) : super(initialValue);

  @override
  Future<StatusRequest> fetchSuggestedValuesLocal() async {
    final res = await ServiceKeywordsLocal.getBoatNameKeywords(textFormValue);
    if (res.isSuccess && res.hasData) {
      final data = List.from(res.data);
      res.data = List<String>.generate(data.length, (index) => data[index]["boatName"]);
    }
    return res;
  }

  @override
  Future<StatusRequest> fetchSuggestedValuesRemote() async {
    final res = await ServiceKeywordsApi().getBoatNameKeywords(textFormValue);
    if (res.isSuccess && res.hasData) {
      final data = List.from(res.data);
      res.data = List<String>.generate(data.length, (index) => data[index]["boatName"]);
    }
    return res;
  }
}
