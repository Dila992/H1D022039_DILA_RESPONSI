import 'dart:convert';
import '/helpers/api.dart';
import '/helpers/api_url.dart';
import '/model/durasi_tur.dart';

class DurasiTurBloc {
  static Future<List<DurasiTur>> getDurasiTur() async {
    String apiUrl = ApiUrl.listProduk;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listProduk = (jsonObj as Map<String, dynamic>)['data'];
    List<DurasiTur> produks = [];
    for (int i = 0; i < listProduk.length; i++) {
      produks.add(DurasiTur.fromJson(listProduk[i]));
    }
    return produks;
  }

  static Future addDurasiTur({DurasiTur? durasi}) async {
    String apiUrl = ApiUrl.createProduk;

    var body = {
      "tour": durasi!.tour,
      "days": durasi.cost.toString(),
      "cost": durasi.cost.toString()
    };

    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future updateDurasiTur({required DurasiTur durasi}) async {
    String apiUrl = ApiUrl.updatePariwisata(durasi.id!);
    print(apiUrl);

    var body = {
      "tour": durasi.tour,
      "days": durasi.days,
      "cost": durasi.cost
    };
    print("Body : $body");
    var response = await Api().put(apiUrl, jsonEncode(body));
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> deleteProduk({int? id}) async {
    String apiUrl = ApiUrl.deletePariwisata(id!);

    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}
