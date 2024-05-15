import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/domain/entity/notification/notification.dart';

class NotiApi {
  final DioClient _dioClient;
  NotiApi(this._dioClient);

  Future<List<Noti>> getNotifications(int id) async {
    final res = await _dioClient.dio
        .get(Endpoints.baseUrl + '/api/notification/getByReceiverId/$id');
    if (res.statusCode != 200) {
      return [];
    }
    final data = res.data['result'];
    data.forEach((element) {
      if (element['message'] != null) {
        if (element['message']['interview'] != null) {
          element['interview'] = element['message']['interview'];
          print("222+" + element['interview'].toString());
        }
      }
    });
    print("111+" + res.data.toString());

    final List<Noti> notiApiRes =
        List<Noti>.from(data.map((i) => Noti.fromJson(i)));

    return notiApiRes;
  }
}
