import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart';

class NotificationService {
  static final instance = FirebaseMessaging.instance;
  static const fcmUrl = 'https://fcm.googleapis.com/fcm/send';
  // TODO: add your firebase server key
  static const serverKey ='AAAAr93e30c:APA91bGKeRIviAgxBl4s-6FT32my_qeUn6mfh5g2yPtmz84LlJUAHKQryET7of0qyo3O8GbUcYCDp4zRve7qe6roJq2HmEbhX3dx4F_RV8YYFNlGCiQzI8tLBQ4SmaJZiGegriYXeRk_';

  static Future<void> sendNotification({
    required String title,
    required String body,
  }) async {
    var jsonHeader = {
      'content-type': 'application/json',
      'authorization': 'key=$serverKey',
    };

    var jsonBody = {
      'to': '/topics/chat',
      'notification': {'title': title, 'body': body},
    };

    print('headers: ${jsonEncode(jsonHeader)}');
    print('body: ${jsonEncode(jsonBody)}');

    var response = await post(
      Uri.parse(fcmUrl),
      headers: jsonHeader,
      body: jsonEncode(jsonBody),
    );

    print(response.statusCode);
    print(response.body);
  }
}