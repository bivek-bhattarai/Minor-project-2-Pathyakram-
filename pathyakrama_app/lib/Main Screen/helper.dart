import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MainScreenHelper {

  static Future getUniversities() async {
    String universityUrl = 'http://10.0.2.2:3001/api/universities';
    Map dataAsIsIt = {};

    await http.get(Uri.parse(universityUrl)).then((value) => {
          dataAsIsIt = jsonDecode(value.body),
        });
    return dataAsIsIt;
  }

  static Future getNotifications() async {
    final CollectionReference ref =
    FirebaseFirestore.instance.collection('pushNotification');
    List allNotifications = [];
    print('BivekBhattarai');
    await ref.get().then((res) {
      for (var element in res.docs) {
        print('BivekBhattarai');
        print(element);
        var data = {'ID': element.id, 'Notice': element.get('notice')};
        print(data);
        allNotifications.add(data);
      }
    });
    return allNotifications;
  }

}
